defmodule Day12 do
  def part_one(input \\ InputFile) do
    input.contents_of(12, :stream)
    |> Enum.map(fn row -> row |> String.split("", trim: true) end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} -> row |> Enum.with_index() |> Enum.map(fn {char, x} -> {char, {x, y}} end) end)
    |> Enum.reduce(%{}, &build/2)
    |> Enum.flat_map(fn {_char, regions} -> Enum.map(regions, &cost/1) end)
    |> Enum.sum()
  end

  def part_two(_input \\ InputFile) do

  end

  def build({char, {x, y}}, regions) do
    neighbors = MapSet.new([{x - 1, y}, {x, y + 1}, {x + 1, y}, {x, y - 1}])

    {to_join, keep} = regions
    |> Map.get(char, [])
    |> Enum.split_with(fn region -> MapSet.intersection(region, neighbors) |> Enum.any?() end)

    joined = Enum.reduce([MapSet.new([{x, y}]) | to_join], &MapSet.union/2) |> MapSet.put({x, y})
    Map.put(regions, char, [joined | keep])
  end

  def cost(region) do
    area = Enum.count(region)
    perimeter = Enum.map(region, fn {x, y} -> 4 - Enum.count([{x - 1, y}, {x, y + 1}, {x + 1, y}, {x, y - 1}], &MapSet.member?(region, &1)) end) |> Enum.sum()

    area * perimeter
  end
end
