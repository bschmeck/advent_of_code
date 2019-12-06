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
    case Map.get(opcodes, i) do
      1 -> opcodes |> op(i, &Kernel.+/2) |> execute(i + 4)
      2 -> opcodes |> op(i, &Kernel.*/2) |> execute(i + 4)
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

  def read(machine, addr), do: Map.get(machine, addr)
  def write(machine, addr, value), do: Map.put(machine, addr, value)

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], i, map) do
    assign_offsets(rest, i + 1, write(map, i, op))
  end
end
