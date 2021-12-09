defmodule Day09 do
  def part_one(input) do
    map = map(input)

    map
    |> Enum.filter(fn {pos, value} -> lowest?(pos, value, map) end)
    |> Enum.map(fn {_pos, value} -> value + 1 end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input) do
    map = map(input)

    map
    |> Enum.filter(fn {pos, value} -> lowest?(pos, value, map) end)
    |> Enum.map(fn {pos, _value} -> pos end)
    |> Enum.map(fn pos -> basin_size([pos], [], MapSet.new([pos]), map) end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp basin_size([], points, _seen, _map), do: Enum.count(points)

  defp basin_size([pos | rest], points, seen, map) do
    case map[pos] do
      v when v >= 0 and v < 9 ->
        n = pos |> neighbors() |> MapSet.new() |> MapSet.difference(seen)
        basin_size(rest ++ MapSet.to_list(n), [pos | points], MapSet.union(seen, n), map)

      _ ->
        basin_size(rest, points, seen, map)
    end
  end

  defp lowest?(pos, value, map) do
    pos
    |> neighbors()
    |> Enum.map(fn n -> Map.get(map, n, 10) end)
    |> Enum.all?(&(&1 > value))
  end

  defp neighbors({x, y}), do: [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]

  defp map(input) do
    9
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.with_index()
    |> Stream.flat_map(fn {row, y} ->
      row
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {value, x} -> {{x, y}, value} end)
    end)
    |> Enum.into(%{})
  end
end
