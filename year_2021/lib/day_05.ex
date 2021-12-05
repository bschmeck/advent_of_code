defmodule Day05 do
  alias Day05.Line

  def part_one(input) do
    count(input, fn l -> Line.horizontal?(l) || Line.vertical?(l) end)
  end

  def part_two(input) do
    count(input, fn _l -> true end)
  end

  defp count(input, filter_fn) do
    5
    |> input.contents_of(:stream)
    |> Stream.map(&Line.parse/1)
    |> Stream.filter(filter_fn)
    |> Stream.flat_map(fn l -> Line.points(l) end)
    |> Enum.reduce(%{}, fn point, counts -> Map.update(counts, point, 1, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.count(fn c -> c > 1 end)
  end
end
