defmodule Day11.Seats do
  defstruct [:grid]

  def new(input), do: %__MODULE__{grid: gridify(input, 0, %{}) }

  def stabilize(%__MODULE__{grid: grid}, advancer) do
    case advancer.(grid) do
      {:stable, grid} -> %__MODULE__{grid: grid}
      {:change, grid} -> stabilize(%__MODULE__{grid: grid}, advancer)
    end
  end

  def count_empty_seats(%__MODULE__{grid: grid}) do
    grid
    |> Map.values()
    |> Enum.count(fn a -> a == "#" end)
  end

  defp gridify([], _, grid), do: grid
  defp gridify([line | rest], row, grid) do
    grid = line
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.into(grid, fn {char, col} -> {{row, col}, char} end)

    gridify(rest, row + 1, grid)
  end
end
