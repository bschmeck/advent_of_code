defmodule Day11.Robot do
  defstruct direction: :up, location: {0, 0}

  def move(%__MODULE__{direction: :down} = robot, :left), do: do_move(robot, :right)
  def move(%__MODULE__{direction: :down} = robot, :right), do: do_move(robot, :left)
  def move(%__MODULE__{direction: :left} = robot, :left), do: do_move(robot, :down)
  def move(%__MODULE__{direction: :left} = robot, :right), do: do_move(robot, :up)
  def move(%__MODULE__{direction: :right} = robot, :left), do: do_move(robot, :up)
  def move(%__MODULE__{direction: :right} = robot, :right), do: do_move(robot, :down)
  def move(%__MODULE__{direction: :up} = robot, :left), do: do_move(robot, :left)
  def move(%__MODULE__{direction: :up} = robot, :right), do: do_move(robot, :right)

  defp do_move(%__MODULE__{location: {x, y}} = robot, :down), do: %__MODULE__{robot | direction: :down, location: {x, y-1}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :left), do: %__MODULE__{robot | direction: :left, location: {x-1, y}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :right), do: %__MODULE__{robot | direction: :right, location: {x+1, y}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :up), do: %__MODULE__{robot | direction: :up, location: {x, y+1}}
end
