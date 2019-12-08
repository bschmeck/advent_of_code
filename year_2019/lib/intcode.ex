defmodule Intcode do
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

  def execute(machine, input \\ 1), do: execute(machine, 0, input)
  defp execute(machine, sp, input) do
    opcode = machine |> read(sp) |> rem(100)

    case opcode do
      1 -> machine |> op(sp, &Kernel.+/2) |> execute(sp + 4, input)
      2 -> machine |> op(sp, &Kernel.*/2) |> execute(sp + 4, input)
      3 -> machine |> write_input(sp, input) |> execute(sp + 2, input)
      4 -> machine |> output(sp) |> execute(sp + 2, input)
      5 ->
        sp = machine |> jump_if_true(sp)
        execute(machine, sp, input)
      6 ->
        sp = machine |> jump_if_false(sp)
        execute(machine, sp, input)
      7 -> machine |> less_than(sp) |> execute(sp + 4, input)
      8 -> machine |> equal_to(sp) |> execute(sp + 4, input)
      99 -> machine
    end
  end

  defp equal_to(machine, sp) do
    addr = read(machine, sp + 3)
    case args(machine, sp, 2) do
      [a, a] -> write(machine, addr, 1)
      _ -> write(machine, addr, 0)
    end
  end

  defp less_than(machine, sp) do
    addr = read(machine, sp + 3)
    case args(machine, sp, 2) do
      [a, b] when a < b -> write(machine, addr, 1)
      _ -> write(machine, addr, 0)
    end
  end

  defp jump_if_true(machine, sp) do
    case args(machine, sp, 2) do
      [v, addr] when v != 0 -> addr
      _ -> sp + 3
    end
  end

  defp jump_if_false(machine, sp) do
    case args(machine, sp, 2) do
      [0, addr] -> addr
      _ -> sp + 3
    end
  end

  defp op(machine, sp, f) do
    [a, b] = args(machine, sp, 2)
    addr = read(machine, sp + 3)
    write(machine, addr, f.(a, b))
  end

  defp args(machine, sp, nargs) do
    modes = machine |> read(sp) |> div(100)
    args_from_modes(machine, sp + 1, modes, nargs, [])
  end
  defp args_from_modes(_machine, _sp, _modes, 0, args), do: Enum.reverse(args)
  defp args_from_modes(machine, sp, modes, n, args) when rem(modes, 10) == 0 do
    addr = read(machine, sp)
    arg = read(machine, addr)
    args_from_modes(machine, sp + 1, div(modes, 10), n - 1, [arg | args])
  end
  defp args_from_modes(machine, sp, modes, n, args) when rem(modes, 10) == 1 do
    arg = read(machine, sp)
    args_from_modes(machine, sp + 1, div(modes, 10), n - 1, [arg | args])
  end

  defp write_input(machine, sp, input) do
    addr = read(machine, sp + 1)
    write(machine, addr, input)
  end

  defp output(machine, sp) do
    [arg] = args(machine, sp, 1)
    IO.puts arg
    machine
  end

  def read(machine, addr), do: Map.get(machine, addr)
  def write(machine, addr, value), do: Map.put(machine, addr, value)

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], sp, map) do
    assign_offsets(rest, sp + 1, write(map, sp, op))
  end
end
