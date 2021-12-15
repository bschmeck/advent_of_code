defmodule Day15.Route do
  defstruct [:total_risk, :current_node, :seen, :estimate]

  def new({x, y} = _goal) do
    %__MODULE__{
      total_risk: 0,
      current_node: {0, 0},
      seen: MapSet.new([{0, 0}]),
      estimate: x + y
    }
  end

  def move(route, {x, y} = pos, risk, {g_x, g_y} = _goal) do
    %__MODULE__{
      total_risk: route.total_risk + risk,
      current_node: pos,
      seen: MapSet.put(route.seen, pos),
      estimate: route.total_risk + risk + g_x - x + g_y - y
    }
  end

  def visited?(%__MODULE__{seen: seen}, pos), do: MapSet.member?(seen, pos)
end
