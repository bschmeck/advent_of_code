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

  def execute(machine), do: execute(machine, 0)
  defp execute(machine, sp) do
    {_modes, opcode} = machine |> read(sp) |> divrem(100)

    case opcode do
      1 -> machine |> op(sp, &Kernel.+/2) |> execute(sp + 4)
      2 -> machine |> op(sp, &Kernel.*/2) |> execute(sp + 4)
      3 -> machine |> write_input(sp) |> execute(sp + 2)
      4 -> machine |> output(sp) |> execute(sp + 2)
      99 -> machine
    end
  end

  defp op(machine, sp, f) do
    a = read(machine, sp + 1)
    b = read(machine, sp + 2)
    c = read(machine, sp + 3)
    val_a = read(machine, a)
    val_b = read(machine, b)
    write(machine, c, f.(val_a, val_b))
  end

  defp write_input(machine, sp) do
    addr = read(machine, sp + 1)
    write(machine, addr, input())
  end

  defp input, do: 1

  defp output(machine, sp) do
    addr = read(machine, sp + 1)
    IO.puts read(machine, addr)
    machine
  end

  def read(machine, addr), do: Map.get(machine, addr)
  def write(machine, addr, value), do: Map.put(machine, addr, value)

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], sp, map) do
    assign_offsets(rest, sp + 1, write(map, sp, op))
  end

  defp divrem(a, b), do: {div(a, b), rem(a, b)}
end
