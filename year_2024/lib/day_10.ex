defmodule Day10 do
  def part_one(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> Enum.map(fn row -> row |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} -> row |> Enum.with_index() |> Enum.map(fn {lvl, x} -> {lvl, {x, y}} end) end)
    |> Enum.reduce(%{}, fn {lvl, pt}, map -> Map.update(map, lvl, MapSet.new([pt]), &MapSet.put(&1, pt)) end)
    |> climb()
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> Enum.map(fn row -> row |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} -> row |> Enum.with_index() |> Enum.map(fn {lvl, x} -> {lvl, {x, y}} end) end)
    |> Enum.reduce(%{}, fn {lvl, pt}, map -> Map.update(map, lvl, MapSet.new([pt]), &MapSet.put(&1, pt)) end)
    |> rate()
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def climb(points) do
    points
    |> Map.get(0)
    |> Enum.map(&MapSet.new([&1]))
    |> climb(points, 1)
  end
  def climb(locs, _points, 10), do: locs
  def climb(locs, points, next_level) do
    valid_steps = Map.get(points, next_level)
    locs
    |> Enum.map(&expand/1)
    |> Enum.map(&MapSet.intersection(&1, valid_steps))
    |> climb(points, next_level + 1)
  end

  def rate(points) do
    points
    |> Map.get(9)
    |> Enum.map(&({&1, 1}))
    |> Enum.into(%{})
    |> rate(points, 8)
  end

  def rate(ratings, _points, -1), do: ratings
  def rate(ratings, points, next_level) do
    points
    |> Map.get(next_level)
    |> Enum.map(fn {x, y} ->
      rating = [{x - 1, y}, {x, y + 1}, {x + 1, y}, {x, y - 1}]
      |> Enum.map(&Map.get(ratings, &1, 0))
      |> Enum.reduce(&Kernel.+/2)
      {{x, y}, rating}
    end)
    |> Enum.into(%{})
    |> rate(points, next_level - 1)
  end

  def expand(set) do
    set
    |> Enum.flat_map(fn {x, y} -> [{x - 1, y}, {x, y + 1}, {x + 1, y}, {x, y - 1}] end)
    |> Enum.into(%MapSet{})
  end
end
