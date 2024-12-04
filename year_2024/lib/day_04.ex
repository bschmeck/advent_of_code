defmodule Day04 do
  def part_one(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, map ->
      row
      |> Enum.with_index()
      |> Enum.reduce(map, fn { elt, x}, m -> Map.update(m, elt, [{x, y}], &([{x, y} | &1])) end)
    end)
    |> count()
  end

  def part_two(_input \\ InputFile) do

  end

  def count(chars) do
    locs = expand_X(%{}, Map.get(chars, "X"))
    locs = expand_M(%{}, locs, Map.get(chars, "M"))
    locs = expand_A(%{}, locs, Map.get(chars, "A"))
    expand_S([], locs, Map.get(chars, "S")) |> Enum.count()
  end

  def expand_X(locs, []), do: locs
  def expand_X(locs, [{x, y} | rest]) do
    [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]
    |> Enum.map(fn {dx, dy} -> {{x + dx, y + dy}, [{dx, dy}]} end)
    |> Enum.into(%{})
    |> Map.merge(locs, fn _k, pos, others -> pos ++ others end)
    |> expand_X(rest)
  end

  def expand_M(locs, _dirs, []), do: locs
  def expand_M(locs, dirs, [{x, y} | rest]) do
    Map.get(dirs, {x, y}, [])
    |> Enum.map(fn {dx, dy} -> {{x + dx, y + dy}, [{dx, dy}]} end)
    |> Enum.into(%{})
    |> Map.merge(locs, fn _k, pos, others -> pos ++ others end)
    |> expand_M(dirs, rest)
  end

  def expand_A(locs, _dirs, []), do: locs
  def expand_A(locs, dirs, [{x, y} | rest]) do
    Map.get(dirs, {x, y}, [])
    |> Enum.map(fn {dx, dy} -> {{x + dx, y + dy}, [{dx, dy}]} end)
    |> Enum.into(%{})
    |> Map.merge(locs, fn _k, pos, others -> pos ++ others end)
    |> expand_A(dirs, rest)
  end

  def expand_S(locs, _dirs, []), do: locs
  def expand_S(locs, dirs, [{x, y} | rest]) do
    (Map.get(dirs, {x, y}, []) ++ locs) |> expand_S(dirs, rest)
  end
end
