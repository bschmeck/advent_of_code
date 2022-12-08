defmodule Day08 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(8, :stream)
    |> Day08.Grid.build(fn l -> l |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

    grid.map
    |> Map.keys()
    |> Enum.count(fn p -> visible?(p, grid) end)
  end

  def part_two(input \\ InputFile) do

  end

  defp visible?({x, _}, %Day08.Grid{width: w}) when x == 0 or x + 1 == w, do: true
  defp visible?({_, y}, %Day08.Grid{height: h}) when y == 0 or y + 1 == h, do: true
  defp visible?(point, grid) do
    tree = Map.get(grid.map, point)

    [:left, :right, :up, :down]
    |> Enum.any?(fn dir ->
      points_from(point, grid, dir)
      |> Enum.all?(fn pt -> Map.get(grid.map, pt) < tree end)
    end)
  end

  defp points_from({x, y}, _grid, :left), do: for x2 <- 0..x-1, do: {x2, y}
  defp points_from({x, y}, %Day08.Grid{width: w}, :right), do: for x2 <- w-1..x+1, do: {x2, y}
  defp points_from({x, y}, _grid, :up), do: for y2 <- 0..y-1, do: {x, y2}
  defp points_from({x, y}, %Day08.Grid{height: h}, :down), do: for y2 <- h-1..y+1, do: {x, y2}
end
