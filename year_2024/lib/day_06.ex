defmodule Day06 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(6, :stream)
    |> Grid.build(&(String.split(&1, "", trim: true)))

    pos = Enum.find(grid.map, fn {_pos, c} -> c == "^" end) |> elem(0)
    state = {pos, {0, -1}}

    walk(state, grid, MapSet.new()) |> Enum.count()
  end

  def part_two(_input \\ InputFile) do

  end

  def walk({{-1, _y}, _vec}, _grid, seen), do: seen
  def walk({{_x, -1}, _vec}, _grid, seen), do: seen
  def walk({{x, _y}, _vec}, %Grid{width: w}, seen) when x == w, do: seen
  def walk({{_x, y}, _vec}, %Grid{height: h}, seen) when y == h, do: seen
  def walk({pos, _vec} = state, grid, seen) do
    state = step(state, grid)
    walk(state, grid, MapSet.put(seen, pos))
  end

  def step({{x, y}, {dx, dy}}, grid) do
    pos = {x+dx, y+dy}
    case Map.get(grid.map, pos) do
      "#" -> {{x, y}, rotate({dx, dy})}
      _ -> {pos, {dx, dy}}
    end
  end

  def rotate({0, -1}), do: {1, 0}
  def rotate({1, 0}), do: {0, 1}
  def rotate({0, 1}), do: {-1, 0}
  def rotate({-1, 0}), do: {0, -1}
end
