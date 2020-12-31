defmodule Day20 do
  def part_one(file_reader \\ InputFile) do
    tiles = file_reader.contents_of(20, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_by(fn s -> s == "" end)
    |> Enum.reject(fn
      [""] -> true
      _ -> false
    end)
    |> Enum.map(&parse_tile/1)
    |> Enum.into(%{})

    Map.values(tiles)
    |> Enum.flat_map(&Day20.Border.to_list/1)
    |> Enum.reduce(%{}, fn edge, map -> Map.update(map, edge, 1, &(&1 + 1)) end)
    |> Map.values()
  end

  defp parse_tile([<<"Tile ", rest :: binary>> | rows]) do
    {id, ":"} = Integer.parse(rest)

    {id, Day20.Border.parse(rows)}
  end
end
