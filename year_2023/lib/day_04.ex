defmodule Day04 do
  def part_one(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&parse/1)
    |> Enum.map(&score/1)
    |> Enum.sum
  end

  def parse(row) do
    row
    |> String.split(": ")
    |> Enum.at(1)
    |> String.split(" | ")
    |> Enum.map(fn nums -> nums |> String.split() |> Enum.map(&String.to_integer/1) |> Enum.into(%MapSet{}) end)
  end

  def score([winners, given]) do
    case MapSet.intersection(winners, given) |> MapSet.size() do
      0 -> 0
      n -> 2 ** (n - 1)
    end
  end
end
