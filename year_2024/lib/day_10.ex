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

  def part_two(_input \\ InputFile) do

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

  def expand(set) do
    set
    |> Enum.flat_map(fn {x, y} -> [{x - 1, y}, {x, y + 1}, {x + 1, y}, {x, y - 1}] end)
    |> Enum.into(%MapSet{})
  end
end
