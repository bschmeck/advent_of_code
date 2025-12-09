defmodule Day09 do
  def part_one(input \\ InputFile) do
    input.contents_of(9, :stream)
    |> Enum.map(&parse/1)
    |> pairs([])
    |> Enum.map(&area/1)
    |> Enum.max()
  end

  def part_two(_input \\ InputFile) do

  end

  def area({{x1, y1}, {x2, y2}}), do: (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  def pairs([], acc), do: acc
  def pairs([pt | rest], acc) do
    ret = Stream.cycle([pt]) |> Enum.zip(rest)
    pairs(rest, ret ++ acc)
  end

  def parse(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
