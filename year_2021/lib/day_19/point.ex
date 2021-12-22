defmodule Day19.Point do
  defstruct [:x, :y, :z]

  def new(x, y, z), do: %__MODULE__{x: x, y: y, z: z}

  def reorient(point, origin), do: new(point.x - origin.x, point.y - origin.y, point.z - origin.z)

  def parse(str) do
    str
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y, z] -> new(x, y, z) end)
  end
end
