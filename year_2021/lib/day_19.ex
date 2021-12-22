defmodule Day19 do
  alias Day19.Point

  def part_one(input) do
    parse(input)
  end

  def overlapping(a, b) do
    a
    |> subsets_of()
    |> Enum.find(fn subset_a ->
      b
      |> subsets_of()
      |> Enum.any?(fn subset_b ->
        MapSet.intersection(subset_a, subset_b) |> Enum.count() |> IO.inspect() >= 12
      end)
    end)
  end

  defp subsets_of(list) do
    Stream.resource(
      fn -> {list, []} end,
      fn
        {[pt | rest], seen} ->
          IO.puts("Origin of #{inspect(pt)}")
          {[points_wrt(rest ++ seen, pt)], {rest, [pt | seen]}}

        {[], _seen} ->
          {:halt, nil}
      end,
      fn _ -> nil end
    )
  end

  defp points_wrt(points, origin) do
    points
    |> Enum.map(fn pt -> Point.reorient(pt, origin) end)
    |> Enum.into(MapSet.new([Point.new(0, 0, 0)]))
  end

  def parse(input) do
    19
    |> input.contents_of()
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_station/1)
  end

  defp parse_station(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Kernel.tl()
    |> Enum.map(&Point.parse/1)
  end
end
