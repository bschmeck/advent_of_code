defmodule Day11.Seats do
  defstruct [:grid]

  def new(input), do: %__MODULE__{grid: gridify(input, 0, %{}) }

  def stabilize(%__MODULE__{grid: grid}, opts) do
    case advance(grid, opts) do
      {:stable, grid} -> %__MODULE__{grid: grid}
      {:change, grid} -> stabilize(%__MODULE__{grid: grid}, opts)
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

  defp advance(grid, opts) do
    grid
    |> Enum.map(fn entry -> new_value(entry, grid, opts) end)
    |> Enum.reduce({:stable, %{}}, fn
      {pos, val, val}, {outcome, grid} -> {outcome, Map.put(grid, pos, val)}
      {pos, _old_val, new_val}, {_, grid} -> {:change, Map.put(grid, pos, new_val)}
    end)
  end

  def new_value({pos, "."}, _grid, _opts), do: {pos, ".", "."}
  def new_value({pos, "L"}, grid, ignore_floor: ignore_floor, threshold: _) do
    pos
    |> adjacent(grid, ignore_floor)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        0 -> {pos, "L", "#"}
        _ -> {pos, "L", "L"}
    end
  end
  def new_value({pos, "#"}, grid, ignore_floor: ignore_floor, threshold: threshold) do
    pos
    |> adjacent(grid, ignore_floor)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        x when x >= threshold -> {pos, "#", "L"}
        _ -> {pos, "#", "#"}
    end
  end

  def adjacent({x, y}, grid, ignore_floor) do
    for i <- -1..1 do
              for j <- -1..1, do: {i, j}
    end
    |> Enum.concat()
    |> Enum.reject(fn
      {0, 0} -> true
      _ -> false
    end)
    |> Enum.map(&(seat_in_dir(&1, {x, y}, 1, grid, ignore_floor)))
  end

  def seat_in_dir({dx, dy}, {x, y}, i, grid, false) do
    pos = {x + dx * i, y + dy * i}
    Map.get(grid, pos, "L")
  end
  def seat_in_dir({dx, dy}, {x, y}, i, grid, true) do
    pos = {x + dx * i, y + dy * i}
    case Map.get(grid, pos, "L") do
      "." -> seat_in_dir({dx, dy}, {x, y}, i + 1, grid, true)
      seat -> seat
    end
  end
end
