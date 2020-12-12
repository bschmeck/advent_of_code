defmodule Day12.WaypointShip do
  defstruct x: 0, y: 0, wx: 10, wy: 1

  def follow_instructions(instrs), do: follow_instructions(instrs, %__MODULE__{})
  def follow_instructions([], ship), do: ship

  def follow_instructions([instr | rest], ship),
    do: follow_instructions(rest, follow_instruction(instr, ship))

  def follow_instruction({"N", v}, ship), do: %__MODULE__{ship | wy: ship.wy + v}
  def follow_instruction({"S", v}, ship), do: %__MODULE__{ship | wy: ship.wy - v}
  def follow_instruction({"E", v}, ship), do: %__MODULE__{ship | wx: ship.wx + v}
  def follow_instruction({"W", v}, ship), do: %__MODULE__{ship | wx: ship.wx - v}
  def follow_instruction({"L", v}, ship), do: rotate(ship, 360 - v)
  def follow_instruction({"R", v}, ship), do: rotate(ship, v)

  def follow_instruction({"F", v}, ship),
    do: %__MODULE__{ship | x: ship.x + v * ship.wx, y: ship.y + v * ship.wy}

  def rotate(ship, 90), do: %__MODULE__{ship | wx: ship.wy, wy: -ship.wx}
  def rotate(ship, 180), do: ship |> rotate(90) |> rotate(90)
  def rotate(ship, 270), do: ship |> rotate(90) |> rotate(90) |> rotate(90)
end
