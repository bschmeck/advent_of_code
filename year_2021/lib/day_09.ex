defmodule Day09 do
  def part_one(input) do
    map = map(input)

    map
    |> Map.keys()
    |> Enum.filter(fn pos -> lowest?(pos, map) end)
    |> Enum.map(fn pos -> map[pos] + 1 end)
    |> Enum.reduce(&Kernel.+/2)
  end

  defp lowest?(pos, map) do
    value = map[pos]

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
    |> Stream.flat_map(fn {row, x} ->
      row
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {value, y} -> {{x, y}, value} end)
    end)
    |> Enum.into(%{})
  end
end
