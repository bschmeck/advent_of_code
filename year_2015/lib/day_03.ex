defmodule Day03 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(3)
    |> String.split("", trim: true)
    |> move()
    |> MapSet.size()
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(3)
    |> String.split("", trim: true)
    |> move2()
    |> MapSet.size()
  end

  def move(dirs), do: move(dirs, {0, 0}, MapSet.new([{0,0}]))
  defp move([], _pt, points), do: points
  defp move(["^" | rest], {x, y}, points) do
    new_pt = {x, y + 1}
    move(rest, new_pt, MapSet.put(points, new_pt))
  end
  defp move(["v" | rest], {x, y}, points) do
    new_pt = {x, y - 1}
    move(rest, new_pt, MapSet.put(points, new_pt))
  end
  defp move([">" | rest], {x, y}, points) do
    new_pt = {x+1, y}
    move(rest, new_pt, MapSet.put(points, new_pt))
  end
  defp move(["<" | rest], {x, y}, points) do
    new_pt = {x-1, y}
    move(rest, new_pt, MapSet.put(points, new_pt))
  end

  def move2(dirs), do: move2(dirs, [{0, 0}, {0, 0}], MapSet.new([{0,0}]))
  defp move2([], _pt, points), do: points
  defp move2(["^" | rest], [{x, y}, pt2], points) do
    new_pt = {x, y + 1}
    move2(rest, [pt2, new_pt], MapSet.put(points, new_pt))
  end
  defp move2(["v" | rest], [{x, y}, pt2], points) do
    new_pt = {x, y - 1}
    move2(rest, [pt2, new_pt], MapSet.put(points, new_pt))
  end
  defp move2([">" | rest], [{x, y}, pt2], points) do
    new_pt = {x+1, y}
    move2(rest, [pt2, new_pt], MapSet.put(points, new_pt))
  end
  defp move2(["<" | rest], [{x, y}, pt2], points) do
    new_pt = {x-1, y}
    move2(rest, [pt2, new_pt], MapSet.put(points, new_pt))
  end
end
