defmodule Grid do
  defstruct [:width, :height, :map]

  def build(enum, f \\ fn x -> x end) do
    points = enum
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, map ->
      f.(row)
      |> Enum.with_index()
      |> Enum.reduce(map, fn {elt, x}, m -> Map.put(m, {x, y}, elt) end)
    end)

    max_x = Map.keys(points) |> Enum.map(fn {x, _y} -> x end) |> Enum.max()
    max_y = Map.keys(points) |> Enum.map(fn {_x, y} -> y end) |> Enum.max()

    %__MODULE__{width: max_x + 1, height: max_y + 1, map: points}
  end

  def row(%__MODULE__{width: w}, y), do: for(x <- 0..w-1, do: {x, y})
  def col(%__MODULE__{height: h}, x), do: for(y <- 0..h-1, do: {x, y})
end
