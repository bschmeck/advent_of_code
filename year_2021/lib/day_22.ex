defmodule Day22 do
  alias Day22.RangeParser

  def part_one(input) do
    22
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line(&1, -50, 50))
    |> Enum.reduce(MapSet.new(), fn
      {:on, cubes}, acc -> MapSet.union(acc, cubes)
      {:off, cubes}, acc -> MapSet.difference(acc, cubes)
    end)
    |> Enum.count()
  end

  def part_two(input) do
    22
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line(&1))
    |> Enum.reduce(MapSet.new(), fn
      {:on, cubes}, acc -> MapSet.union(acc, cubes)
      {:off, cubes}, acc -> MapSet.difference(acc, cubes)
    end)
    |> Enum.count()
  end

  def parse_line(<<"on ", ranges::binary>>), do: {:on, parse_ranges(ranges)}
  def parse_line(<<"off ", ranges::binary>>), do: {:off, parse_ranges(ranges)}
  def parse_line(<<"on ", ranges::binary>>, min, max), do: {:on, parse_ranges(ranges, min, max)}
  def parse_line(<<"off ", ranges::binary>>, min, max), do: {:off, parse_ranges(ranges, min, max)}

  def parse_ranges(ranges) do
    {:ok, parsed, _, _, _, _} = RangeParser.ranges(ranges)
    [min_x, max_x, min_y, max_y, min_z, max_z] = handle_negatives(parsed, [])

    for x <- min_x..max_x, y <- min_y..max_y, z <- min_z..max_z do
      {x, y, z}
    end
    |> Enum.into(MapSet.new())
  end

  def parse_ranges(ranges, min, max) do
    {:ok, parsed, _, _, _, _} = RangeParser.ranges(ranges)
    [min_x, max_x, min_y, max_y, min_z, max_z] = handle_negatives(parsed, [])

    for x <- range(min_x, max_x, min, max),
        y <- range(min_y, max_y, min, max),
        z <- range(min_z, max_z, min, max) do
      {x, y, z}
    end
    |> Enum.into(MapSet.new())
  end

  def range(from, _to, _min, max) when from > max, do: []
  def range(_from, to, min, _max) when to < min, do: []
  def range(from, to, min, max), do: Enum.max([from, min])..Enum.min([to, max])

  defp handle_negatives([], acc), do: Enum.reverse(acc)
  defp handle_negatives(["-", i | rest], acc), do: handle_negatives(rest, [-i | acc])
  defp handle_negatives([i | rest], acc), do: handle_negatives(rest, [i | acc])
end
