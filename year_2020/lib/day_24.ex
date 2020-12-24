defmodule Day24 do
  def part_one(file_reader \\ InputFile) do
    file_reader
    |> initial_tiles()
    |> Map.values()
    |> Enum.count(&(&1))
  end

  def part_two(file_reader \\ InputFile, days \\ 100) do
    file_reader
    |> initial_tiles()
    |> flip(days)
    |> Map.values()
    |> Enum.count(&(&1))
  end

  def initial_tiles(file_reader) do
    file_reader.contents_of(24, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn path, tiles ->
      Map.update(tiles, walk(path), true, &(!&1))
    end)
  end

  def flip(tiles, 0), do: tiles
  def flip(tiles, n) do
    tiles
    |> tiles_to_check()
    |> Enum.reduce(%{}, fn tile, new_tiles -> Map.put(new_tiles, tile, new_color(tile, tiles)) end)
    |> flip(n - 1)
  end

  def new_color(pt, tiles) do
    count = neighbors_of(pt)
    |> Enum.map(&Map.get(tiles, &1, false))
    |> Enum.count(&(&1))

    color = Map.get(tiles, pt, false)

    case {count, color} do
      {1, true} -> true
      {2, _} -> true
      _ -> false
    end
  end

  def neighbors_of(pt) do
    Enum.map(~w[e se ne w sw nw], &walk(&1, pt))
  end

  def tiles_to_check(tiles) do
    tiles
    |> Map.keys()
    |> Enum.flat_map(&neighbors_of/1)
    |> Enum.into(MapSet.new(Map.keys(tiles)))
    |> MapSet.to_list
  end

  def walk(path), do: walk(path, {0, 0})
  def walk("", pt), do: pt
  def walk(<<"e", rest :: binary>>, {x, y}), do: walk(rest, {x+2, y})
  def walk(<<"se", rest :: binary>>, {x, y}), do: walk(rest, {x+1, y-1})
  def walk(<<"ne", rest :: binary>>, {x, y}), do: walk(rest, {x+1, y+1})
  def walk(<<"w", rest :: binary>>, {x, y}), do: walk(rest, {x-2, y})
  def walk(<<"sw", rest :: binary>>, {x, y}), do: walk(rest, {x-1, y-1})
  def walk(<<"nw", rest :: binary>>, {x, y}), do: walk(rest, {x-1, y+1})
end
