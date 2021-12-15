defmodule Day15.Search do
  alias Day15.Grid
  defstruct [:goal_x, :goal_y, :seen, :costs]

  def run(grid) do
    {x, y} = grid.goal
    search = %__MODULE__{goal_x: x, goal_y: y, seen: MapSet.new([{0, 0}]), costs: %{{0, 0} => 0}}

    do_run(grid, search)
  end

  defp do_run(grid, search) do
    {{x, y}, risk} = search.costs |> Enum.min_by(fn {_k, v} -> v end)

    if x == search.goal_x && y == search.goal_y do
      risk
    else
      costs = Map.delete(search.costs, {x, y})
      seen = MapSet.put(search.seen, {x, y})

      costs =
        [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
        |> Enum.map(fn {x_adj, y_adj} -> {x + x_adj, y + y_adj} end)
        |> Enum.filter(fn pos -> Grid.member?(grid, pos) end)
        |> Enum.reject(fn pos -> visited?(search, pos) end)
        |> Enum.map(fn pos -> {pos, risk + Grid.risk_at(grid, pos)} end)
        |> Enum.reduce(costs, fn {pos, new_risk}, costs ->
          Map.update(costs, pos, new_risk, fn a -> Enum.min([a, new_risk]) end)
        end)

      do_run(grid, %__MODULE__{search | seen: seen, costs: costs})
    end
  end

  defp visited?(%__MODULE__{seen: seen}, pos), do: MapSet.member?(seen, pos)
end
