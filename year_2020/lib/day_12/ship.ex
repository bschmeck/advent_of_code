defmodule Day12.Ship do
  defstruct [x: 0, y: 0, dir: 90]

  def follow_instructions(instrs), do: follow_instructions(instrs, %__MODULE__{})
  def follow_instructions([], ship), do: ship
  def follow_instructions([instr | rest], ship), do: follow_instructions(rest, follow_instruction(instr, ship))

  def follow_instruction({"N", v}, ship), do: %__MODULE__{ship | y: ship.y + v}
  def follow_instruction({"S", v}, ship), do: %__MODULE__{ship | y: ship.y - v}
  def follow_instruction({"E", v}, ship), do: %__MODULE__{ship | x: ship.x + v}
  def follow_instruction({"W", v}, ship), do: %__MODULE__{ship | x: ship.x - v}
  def follow_instruction({"L", v}, ship), do: rotate(ship, -v)
  def follow_instruction({"R", v}, ship), do: rotate(ship, v)
  def follow_instruction({"F", v}, %__MODULE__{dir: 0} = ship), do: follow_instruction({"N", v}, ship)
  def follow_instruction({"F", v}, %__MODULE__{dir: 90} = ship), do: follow_instruction({"E", v}, ship)
  def follow_instruction({"F", v}, %__MODULE__{dir: 180} = ship), do: follow_instruction({"S", v}, ship)
  def follow_instruction({"F", v}, %__MODULE__{dir: 270} = ship), do: follow_instruction({"W", v}, ship)

  def rotate(ship, degrees) do
    dir = rem(ship.dir + degrees, 360)
    |> case do
        x when x < 0 -> x + 360
        x -> x
    end
    %__MODULE__{ship | dir: dir}
  end

end
