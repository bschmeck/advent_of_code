defmodule Day06 do
  def part_one(input \\ InputFile) do
    grid = input.contents_of(6, :stream)
    |> Grid.build(&(String.split(&1, "", trim: true)))

    pos = Enum.find(grid.map, fn {_pos, c} -> c == "^" end) |> elem(0)
    state = {pos, {0, -1}}

    walk(state, grid, MapSet.new()) |> Enum.count()
  end

  def part_two(input \\ InputFile) do
    grid = input.contents_of(6, :stream)
    |> Grid.build(&(String.split(&1, "", trim: true)))

    pos = Enum.find(grid.map, fn {_pos, c} -> c == "^" end) |> elem(0)
    state = {pos, {0, -1}}

    walk2(state, state, grid, MapSet.new())
  end

  def walk2({{x, y}, {dx, dy}}=state, start, %Grid{width: w, height: h} = grid, placed) do
    case step(state, grid) do
      {{-1, _y}, _vec} -> Enum.count(placed)
      {{_x, -1}, _vec} -> Enum.count(placed)
      {{^w, _y}, _vec} -> Enum.count(placed)
      {{_x, ^h}, _vec} -> Enum.count(placed)
      state ->
        placed_at = {x+dx, y+dy}
        if would_loop?(placed_at, start, grid), do: walk2(state, start, grid, MapSet.put(placed, placed_at)), else: walk2(state, start, grid, placed)
    end
  end

  def would_loop?(state, %Grid{width: w, height: h}=grid, seen) do
    state = step(state, grid)
    if MapSet.member?(seen, state) do
      true
    else
      case state do
        {{-1, _y}, _vec} -> false
        {{_x, -1}, _vec} -> false
        {{^w, _y}, _vec} -> false
        {{_x, ^h}, _vec} -> false
        _ -> would_loop?(state, grid, MapSet.put(seen, state))
      end
    end
  end
  def would_loop?(pos, state, grid) do
    case Map.get(grid.map, pos) do
      "#" -> false
      nil -> false
      _ ->
        new_grid = %Grid{grid | map: Map.put(grid.map, pos, "#")}
        would_loop?(state, new_grid, MapSet.new([state]))
    end
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
