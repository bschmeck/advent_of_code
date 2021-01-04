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

    sides = tiles
    |> Enum.flat_map(fn {id, border} ->
      Day20.Border.possible_sides(border)
      |> Enum.map(&({&1, id}))
    end)
    |> Enum.reduce(%{}, fn {side, id}, map -> Map.update(map, side, [id], fn v -> [id | v] end) end)

    corners = tiles
    |> Enum.filter(fn t -> possible_corder?(t, sides) end)
    |> Enum.map(fn {id, _border} -> id end)

    case Enum.count(corners) do
      4 -> Enum.reduce(corners, &Kernel.*/2)
      _ -> "Found #{Enum.count(corners)} corners"
    end
  end

  defp parse_tile([<<"Tile ", rest :: binary>> | rows]) do
    {id, ":"} = Integer.parse(rest)

    {id, Day20.Border.parse(rows)}
  end

  defp possible_corder?({_id, border}, sides) do
    [border.top, border.right, border.bottom, border.left]
    |> Enum.reject(fn s -> Map.get(sides, s) |> Enum.count() > 1 end)
    |> Enum.count() == 2
  end
end
