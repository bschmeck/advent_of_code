defmodule Day03 do
  def part_one(input \\ InputFile) do
    input.contents_of(3, :stream)
    |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&joltage/1)
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def joltage(l), do: joltage(l, 0)
  def joltage([_elt], j), do: j
  def joltage([tens | rest], j) when tens * 10 + 9 <= j, do: joltage(rest, j)
  def joltage([tens | rest], j) do
    max = tens * 10 + Enum.max(rest)
    joltage(rest, Enum.max([max, j]))
  end
end
