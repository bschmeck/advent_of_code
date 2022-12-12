defmodule Day12 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(12, :stream)
    |> Grid.build(fn line -> String.to_charlist(line) end)

    start = Enum.find(grid.map, fn {_point, char} -> char == 69 end) |> elem(0)

    descend(grid, 83, [{69, start, 0}], [], MapSet.new([start]))
  end

  def part_two(input \\ InputFile) do
    grid = input.contents_of(12, :stream)
    |> Grid.build(fn line -> String.to_charlist(line) end)

    start = Enum.find(grid.map, fn {_point, char} -> char == 69 end) |> elem(0)

    descend(grid, 97, [{69, start, 0}], [], MapSet.new([start]))
  end

  defp descend(_, _, [], [], _), do: -1
  defp descend(grid, target, [], routes, visited), do: descend(grid, target, routes, [], visited)
  defp descend(_grid, target, [{target, _point, count} | _rest], _next, _visited), do: count
  defp descend(grid, target, [loc = {_, _, count} | rest], next, visited) do
    points = steps(grid, loc, visited)
    visited = Enum.reduce(points, visited, fn p, v -> MapSet.put(v, p) end)
    routes = Enum.map(points, fn p -> {Map.get(grid.map, p), p, count + 1} end)
    descend(grid, target, rest, routes ++ next, visited)
  end

  defp steps(grid, {char, {x, y}, _count}, visited) do
    [{-1, 0}, {1, 0}, {0, 1}, {0, -1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn point -> on_map?(grid, point) end)
    |> Enum.reject(fn point -> MapSet.member?(visited, point) end)
    |> Enum.filter(fn point -> valid_step?(char, Map.get(grid.map, point)) end)
  end

  defp on_map?(_grid, {x, y}) when x < 0 or y < 0, do: false
  defp on_map?(%Grid{height: h, width: w}, {x, y}) when x >= w or y >= h, do: false
  defp on_map?(_, _), do: true

  def valid_step?(69, 122), do: true # E -> z
  def valid_step?(97, 83), do: true # a -> S
  def valid_step?(from, to) when from < 97 or to < 97, do: false
  def valid_step?(from, to) when to >= from, do: true
  def valid_step?(from, to), do: from == to + 1

end
