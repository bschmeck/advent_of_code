defmodule Intcode do
  require IEx

  def build(s) do
    s
    |> parse_machine
    |> assign_offsets(0, %{})
  end

  def parse_machine(s) do
    s
    |> String.split(",")
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
  end

  def execute(machine, input \\ [1])
  def execute(machine, {:mailbox, pid}), do: execute(machine, {0, 0}, {receive_fn(), send_fn(pid)})
  def execute(machine, input), do: execute(machine, {0, 0}, {input_fn(input), puts_fn()})
  defp execute(machine, {sp, rb} = ptrs, {input_f, output_f} = io) do
    opcode = machine |> read(sp) |> rem(100)

    case opcode do
      1 -> machine |> op(ptrs, &Kernel.+/2) |> execute({sp + 4, rb}, io)
      2 -> machine |> op(ptrs, &Kernel.*/2) |> execute({sp + 4, rb}, io)
      3 ->
        {val, input_f} = input_f.()
        machine |> write_input(ptrs, val) |> execute({sp + 2, rb}, {input_f, output_f})
      4 -> machine |> output(ptrs, output_f) |> execute({sp + 2, rb}, io)
      5 ->
        sp = machine |> jump_if_true(ptrs)
        execute(machine, {sp, rb}, io)
      6 ->
        sp = machine |> jump_if_false(ptrs)
        execute(machine, {sp, rb}, io)
      7 -> machine |> less_than(ptrs) |> execute({sp + 4, rb}, io)
      8 -> machine |> equal_to(ptrs) |> execute({sp + 4, rb}, io)
      9 ->
        [rb_adj] = args(machine, ptrs, 1)
        execute(machine, {sp + 2, rb + rb_adj}, io)
      99 -> machine
    end
  end

  defp input_fn(l), do: fn -> {hd(l), input_fn(tl(l))} end
  defp receive_fn() do
    fn ->
      receive do
        a -> {a, receive_fn()}
      end
    end
  end

  defp send_fn(pid), do: fn(v) -> send(pid, v) end
  defp puts_fn(), do: fn(v) -> IO.puts v end

  defp equal_to(machine, {sp, rb} = ptrs) do
    addr = write_addr(machine, ptrs, 3)
    case args(machine, {sp, rb}, 2) do
      [a, a] -> write(machine, addr, 1)
      _ -> write(machine, addr, 0)
    end
  end

  defp less_than(machine, ptrs) do
    addr = write_addr(machine, ptrs, 3)
    case args(machine, ptrs, 2) do
      [a, b] when a < b -> write(machine, addr, 1)
      _ -> write(machine, addr, 0)
    end
  end

  defp jump_if_true(machine, {sp, _} = ptrs) do
    case args(machine, ptrs, 2) do
      [v, addr] when v != 0 -> addr
      _ -> sp + 3
    end
  end

  defp jump_if_false(machine, {sp, _} = ptrs) do
    case args(machine, ptrs, 2) do
      [0, addr] -> addr
      _ -> sp + 3
    end
  end

  defp op(machine, ptrs, f) do
    [a, b] = args(machine, ptrs, 2)
    addr = write_addr(machine, ptrs, 3)
    write(machine, addr, f.(a, b))
  end

  defp args(machine, {sp, rb}, nargs) do
    modes = machine |> read(sp) |> div(100)
    args_from_modes(machine, {sp + 1, rb}, modes, nargs, [])
  end
  defp args_from_modes(_machine, _ptrs, _modes, 0, args), do: Enum.reverse(args)
  defp args_from_modes(machine, {sp, rb}, modes, n, args) when rem(modes, 10) == 0 do
    addr = read(machine, sp)
    arg = read(machine, addr)
    args_from_modes(machine, {sp + 1, rb}, div(modes, 10), n - 1, [arg | args])
  end
  defp args_from_modes(machine, {sp, rb}, modes, n, args) when rem(modes, 10) == 1 do
    arg = read(machine, sp)
    args_from_modes(machine, {sp + 1, rb}, div(modes, 10), n - 1, [arg | args])
  end
  defp args_from_modes(machine, {sp, rb}, modes, n, args) when rem(modes, 10) == 2 do
    addr = read(machine, sp) + rb
    arg = read(machine, addr)
    args_from_modes(machine, {sp + 1, rb}, div(modes, 10), n - 1, [arg | args])
  end

  defp write_addr(machine, {sp, rb}, pos) do
    base = (:math.pow(10, pos) * 10) |> round
    mode = machine |> read(sp) |> div(base)
    adjust = case mode do
               2 -> rb
               _ -> 0
             end
    read(machine, sp + pos) + adjust
  end
  defp write_input(machine, ptrs, input) do
    addr = write_addr(machine, ptrs, 1)
    write(machine, addr, input)
  end

  defp output(machine, ptrs, f) do
    [arg] = args(machine, ptrs, 1)
    f.(arg)
    machine
  end

  def read(machine, addr) when addr >= 0, do: Map.get(machine, addr, 0)
  def write(machine, addr, value), do: Map.put(machine, addr, value)

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], sp, map) do
    assign_offsets(rest, sp + 1, write(map, sp, op))
  end
end
