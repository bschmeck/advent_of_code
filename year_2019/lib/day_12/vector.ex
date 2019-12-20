defmodule Day12.Vector do
  defstruct x: 0, y: 0, z: 0

  def new(x, y, z), do: %__MODULE__{x: x, y: y, z: z}

  def adjust(v1, v2), do: new(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

  def invert(%__MODULE__{x: x, y: y, z: z}), do: new(-x, -y, -z)
end
