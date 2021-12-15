defmodule Day15.Route do
  defstruct [:total_risk, :current_node, :seen]

  def new(), do: %__MODULE__{total_risk: 0, current_node: {0, 0}, seen: MapSet.new([{0, 0}])}

  def move(route, pos, risk) do
    %__MODULE__{
      total_risk: route.total_risk + risk,
      current_node: pos,
      seen: MapSet.put(route.seen, pos)
    }
  end

  def visited?(%__MODULE__{seen: seen}, pos), do: MapSet.member?(seen, pos)
end
