defmodule Day14 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(14, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day14.Reindeer.parse/1)
    |> Enum.map(&Day14.Reindeer.distance(&1, 2503))
    |> Enum.max()
  end

  def part_two(file_reader \\ InputFile) do
    reindeer = file_reader.contents_of(14, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day14.Reindeer.parse/1)

    1..2503
    |> Enum.map(&winner_at(reindeer, &1))
    |> Enum.reduce(%{}, fn r, acc -> Map.update(acc, r, 1, &(&1 + 1)) end)
    |> Map.values
    |> Enum.max()
  end

  def winner_at(reindeer, i) do
    reindeer |> Enum.max_by(&Day14.Reindeer.distance(&1, i))
  end
end
