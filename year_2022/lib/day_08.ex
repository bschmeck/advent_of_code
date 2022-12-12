defmodule Day08 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(8, :stream)
    |> Grid.build(fn l -> l |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

    grid.map
    |> Map.keys()
    |> Enum.count(fn p -> visible?(p, grid) end)
  end

  def part_two(input \\ InputFile) do
    grid = input.contents_of(8, :stream)
    |> Grid.build(fn l -> l |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)

    grid.map
    |> Map.keys()
    |> Enum.map(fn p -> scenic_score(p, grid) end)
    |> Enum.max()
  end

  defp visible?(point, grid) do
    tree = Map.get(grid.map, point)

    [:left, :right, :up, :down]
    |> Enum.any?(fn dir ->
      points_to(point, grid, dir)
      |> Enum.all?(fn pt -> Map.get(grid.map, pt) < tree end)
    end)
  end

  defp points_to({x, y}, grid, :left), do: grid |> Grid.row(y) |> Enum.take_while(fn {x2, _} -> x2 < x end)
  defp points_to({x, y}, grid, :right), do: grid |> Grid.row(y) |> Enum.reverse() |> Enum.take_while(fn {x2, _} -> x2 > x end)
  defp points_to({x, y}, grid, :up), do: grid |> Grid.col(x) |> Enum.take_while(fn {_, y2} -> y2 < y end)
  defp points_to({x, y}, grid, :down), do: grid |> Grid.col(x) |> Enum.reverse() |> Enum.take_while(fn {_, y2} -> y2 > y end)

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

  defp points_from(p, grid, dir), do: points_to(p, grid, dir) |> Enum.reverse()

  defp count_view([], _tree, count), do: count
  defp count_view([height | _], tree, count) when height >= tree, do: count + 1
  defp count_view([_ | rest], tree, count), do: count_view(rest, tree, count + 1)
end
