defmodule Day11 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(11, :stream)
    |> Enum.map(&String.trim/1)
    |> gridify()
    |> stabilize()
    |> Map.values()
    |> Enum.count(fn a -> a == "#" end)
  end

  defp gridify(input), do: gridify(input, 0, %{})
  defp gridify([], _, grid), do: grid
  defp gridify([line | rest], row, grid) do
    grid = line
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.into(grid, fn {char, col} -> {{row, col}, char} end)

    gridify(rest, row + 1, grid)
  end

  defp stabilize(grid) do
    case advance(grid) do
      {:stable, grid} -> grid
      {:change, grid} -> stabilize(grid)
    end
  end

  def advance(grid) do
    new_vals = Enum.map(grid, fn entry -> new_value(entry, grid) end)

    outcome = Enum.any?(new_vals, fn {_key, _new_val, result} -> result == :change end)
    |> case do
        true -> :change
        false -> :stable
      end

    {outcome, Enum.into(new_vals, %{}, fn {key, val, _result} -> {key, val} end)}
  end

  def new_value({pos, "."}, _grid), do: {pos, ".", :stable}
  def new_value({pos, "L"}, grid) do
    pos
    |> adjacent(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        0 -> {pos, "#", :change}
        _ -> {pos, "L", :stable}
    end
  end
  def new_value({pos, "#"}, grid) do
    pos
    |> adjacent(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        x when x >= 4 -> {pos, "L", :change}
        _ -> {pos, "#", :stable}
    end
  end

  def adjacent({x, y}, grid) do
    [{-1, -1}, {0, -1}, {1, -1},{-1, 0}, {1, 0},{-1, 1}, {0, 1}, {1, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.map(fn pos -> Map.get(grid, pos, "") end)
  end

  def print(grid) do
    for i <- 0..9 do
      pts = for j <- 0..9, do: {i, j}

      pts
      |> Enum.map(fn pos -> Map.get(grid, pos) end)
      |> Enum.join
      |> IO.puts
    end
  end
end
