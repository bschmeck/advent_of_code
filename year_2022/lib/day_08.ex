defmodule Day08 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(8, :stream)
    |> Day08.Grid.build(fn l -> l |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

    grid.map
    |> Map.keys()
    |> Enum.count(fn p -> visible?(p, grid) end)
  end

  def part_two(input \\ InputFile) do
    grid = input.contents_of(8, :stream)
    |> Day08.Grid.build(fn l -> l |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

    grid.map
    |> Map.keys()
    |> Enum.map(fn p -> scenic_score(p, grid) end)
    |> Enum.max()
  end

  defp visible?({x, _}, %Day08.Grid{width: w}) when x == 0 or x + 1 == w, do: true
  defp visible?({_, y}, %Day08.Grid{height: h}) when y == 0 or y + 1 == h, do: true
  defp visible?(point, grid) do
    tree = Map.get(grid.map, point)

    [:left, :right, :up, :down]
    |> Enum.any?(fn dir ->
      points_to(point, grid, dir)
      |> Enum.all?(fn pt -> Map.get(grid.map, pt) < tree end)
    end)
  end

  defp points_to({x, y}, _grid, :left), do: for x2 <- 0..x-1, do: {x2, y}
  defp points_to({x, y}, %Day08.Grid{width: w}, :right), do: for x2 <- w-1..x+1, do: {x2, y}
  defp points_to({x, y}, _grid, :up), do: for y2 <- 0..y-1, do: {x, y2}
  defp points_to({x, y}, %Day08.Grid{height: h}, :down), do: for y2 <- h-1..y+1, do: {x, y2}

  defp scenic_score(point, grid) do
    tree = Map.get(grid.map, point)

    [:left, :right, :up, :down]
    |> Enum.map(fn dir ->
      points_from(point, grid, dir)
      |> Enum.map(fn p -> Map.get(grid.map, p) end)
      |> count_view(tree, 0)
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp points_from({0, _y}, _grid, :left), do: []
  defp points_from({x, y}, _grid, :left), do: for x2 <- x-1..0, do: {x2, y}
  defp points_from({x, _y}, %Day08.Grid{width: w}, :right) when x == w - 1, do: []
  defp points_from({x, y}, %Day08.Grid{width: w}, :right), do: for x2 <- x+1..w-1, do: {x2, y}
  defp points_from({_x, 0}, _grid, :up), do: []
  defp points_from({x, y}, _grid, :up), do: for y2 <- y-1..0, do: {x, y2}
  defp points_from({_x, y}, %Day08.Grid{height: h}, :down) when y == h - 1, do: []
  defp points_from({x, y}, %Day08.Grid{height: h}, :down), do: for y2 <- y+1..h-1, do: {x, y2}

  defp count_view([], _tree, count), do: count
  defp count_view([height | _], tree, count) when height >= tree, do: count + 1
  defp count_view([_ | rest], tree, count), do: count_view(rest, tree, count + 1)
end
