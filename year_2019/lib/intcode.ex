defmodule Intcode do
  def build(s) do
    s
    |> parse_opcodes
    |> assign_offsets(0, %{})
  end

  def parse_opcodes(s) do
    s
    |> String.split(",")
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
  end

  def execute(opcodes), do: execute(opcodes, 0)
  defp execute(opcodes, i) do
    {_modes, opcode} = opcodes |> read(i) |> divrem(100)

    case opcode do
      1 -> opcodes |> op(i, &Kernel.+/2) |> execute(i + 4)
      2 -> opcodes |> op(i, &Kernel.*/2) |> execute(i + 4)
      3 -> opcodes |> write_input(i) |> execute(i + 2)
      4 -> opcodes |> output(i) |> execute(i + 2)
      99 -> opcodes
    end
  end

  defp op(opcodes, i, f) do
    a = Map.get(opcodes, i + 1)
    b = Map.get(opcodes, i + 2)
    c = Map.get(opcodes, i + 3)
    val_a = Map.get(opcodes, a)
    val_b = Map.get(opcodes, b)
    Map.put(opcodes, c, f.(val_a, val_b))
  end

  defp write_input(opcodes, i) do
    addr = read(opcodes, i + 1)
    write(opcodes, addr, input())
  end

  defp input, do: 1

  defp output(opcodes, i) do
    addr = read(opcodes, i + 1)
    IO.puts read(opcodes, addr)
    opcodes
  end

  def read(machine, addr), do: Map.get(machine, addr)
  def write(machine, addr, value), do: Map.put(machine, addr, value)

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], i, map) do
    assign_offsets(rest, i + 1, write(map, i, op))
  end

  defp divrem(a, b), do: {div(a, b), rem(a, b)}
end
