defmodule Day11 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(11, :stream)
    |> Enum.map(&String.trim/1)
    |> Day11.Seats.new()
    |> Day11.Seats.stabilize(&advance_v1/1)
    |> Day11.Seats.count_empty_seats()
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(11, :stream)
    |> Enum.map(&String.trim/1)
    |> Day11.Seats.new()
    |> Day11.Seats.stabilize(&advance_v2/1)
    |> Day11.Seats.count_empty_seats()
  end

  def advance_v1(grid) do
    new_vals = Enum.map(grid, fn entry -> new_value_v1(entry, grid) end)

    outcome = Enum.any?(new_vals, fn {_key, _new_val, result} -> result == :change end)
    |> case do
        true -> :change
        false -> :stable
      end

    {outcome, Enum.into(new_vals, %{}, fn {key, val, _result} -> {key, val} end)}
  end

  def new_value_v1({pos, "."}, _grid), do: {pos, ".", :stable}
  def new_value_v1({pos, "L"}, grid) do
    pos
    |> adjacent_v1(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        0 -> {pos, "#", :change}
        _ -> {pos, "L", :stable}
    end
  end
  def new_value_v1({pos, "#"}, grid) do
    pos
    |> adjacent_v1(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        x when x >= 4 -> {pos, "L", :change}
        _ -> {pos, "#", :stable}
    end
  end

  def adjacent_v1({x, y}, grid) do
    [{-1, -1}, {0, -1}, {1, -1},{-1, 0}, {1, 0},{-1, 1}, {0, 1}, {1, 1}]
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.map(fn pos -> Map.get(grid, pos, "") end)
  end

  def advance_v2(grid) do
    new_vals = Enum.map(grid, fn entry -> new_value_v2(entry, grid) end)

    outcome = Enum.any?(new_vals, fn {_key, _new_val, result} -> result == :change end)
    |> case do
        true -> :change
        false -> :stable
      end

    {outcome, Enum.into(new_vals, %{}, fn {key, val, _result} -> {key, val} end)}
  end

  def new_value_v2({pos, "."}, _grid), do: {pos, ".", :stable}
  def new_value_v2({pos, "L"}, grid) do
    pos
    |> adjacent_v2(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        0 -> {pos, "#", :change}
        _ -> {pos, "L", :stable}
    end
  end
  def new_value_v2({pos, "#"}, grid) do
    pos
    |> adjacent_v2(grid)
    |> Enum.count(fn seat -> seat == "#" end)
    |> case do
        x when x >= 5 -> {pos, "L", :change}
        _ -> {pos, "#", :stable}
    end
  end

  def adjacent_v2({x, y}, grid) do
    [{-1, -1}, {0, -1}, {1, -1},{-1, 0}, {1, 0},{-1, 1}, {0, 1}, {1, 1}]
    |> Enum.map(&(seat_in_dir(&1, {x, y}, 1, grid)))
  end

  def seat_in_dir({dx, dy}, {x, y}, i, grid) do
    pos = {x + dx * i, y + dy * i}
    case Map.get(grid, pos, "L") do
      "." -> seat_in_dir({dx, dy}, {x, y}, i + 1, grid)
      seat -> seat
    end
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
