defmodule Day17.PocketDimension do
  defstruct grid: []

  def parse(input) do
    grid = input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn
        {"#", x} -> {x, y, 0}
        _ -> nil
      end)
      |> Enum.reject(&(&1 == nil))
    end)

    %__MODULE__{grid: grid}
  end

  def simulate(%__MODULE__{grid: grid}) do
    points = grid |> Enum.into(MapSet.new())

    grid = grid
    |> Enum.flat_map(&neighbors/1)
    |> Enum.reduce(%{}, fn p, map -> Map.update(map, p, 1, &(&1 + 1)) end)
    |> Enum.filter(fn {k, v} -> activate?(k, v, points) end)
    |> Enum.map(&Kernel.elem(&1, 0))

    %__MODULE__{grid: grid}
  end

  def neighbors({x, y, z}) do
    for x <- [-1, 0, 1] do
      for y <- [-1, 0, 1] do
        for z <- [-1, 0, 1] do
          {x, y, z}
        end
      end
    end
    |> Enum.concat()
    |> Enum.concat()
    |> Enum.reject(fn
      {0, 0, 0} -> true
      _ -> false
    end)
    |> Enum.map(fn {dx, dy, dz} -> {x + dx, y + dy, z + dz} end)
  end

  def activate?(k, 2, points), do: MapSet.member?(points, k)
  def activate?(_k, 3, _points), do: true
  def activate?(_k, _n, _points), do: false
end
