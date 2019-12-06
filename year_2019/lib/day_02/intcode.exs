defmodule Day02.Intcode do
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

  def assign_offsets([], _, map), do: map
  def assign_offsets([op | rest], i, map) do
    assign_offsets(rest, i + 1, Map.put(map, i, op))
  end
end

check = fn(raw, noun, verb) ->
  raw
  |> Day02.Intcode.build
  |> Map.put(1, noun)
  |> Map.put(2, verb)
  |> Day02.Intcode.execute
  |> Map.get(0)
end

Day02.Intcode.build("1,0,0,0,99") |> Day02.Intcode.execute |> IO.inspect
Day02.Intcode.build("2,3,0,3,99") |> Day02.Intcode.execute |> IO.inspect
Day02.Intcode.build("2,4,4,5,99,0") |> Day02.Intcode.execute |> IO.inspect
Day02.Intcode.build("1,1,1,4,99,5,6,0,99") |> Day02.Intcode.execute |> IO.inspect

{:ok, raw} = File.read("input.txt")
target = 19690720
combos = for x <- 0..99, y <- 0..99, into: [], do: {x, y}

combos |> Enum.find(fn({noun, verb}) -> check.(raw, noun, verb) == target end) |> IO.inspect
