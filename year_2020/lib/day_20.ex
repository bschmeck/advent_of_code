defmodule Day20 do
  def part_one(file_reader \\ InputFile) do
    tiles =
      file_reader.contents_of(20, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_by(fn s -> s == "" end)
      |> Enum.reject(fn
        [""] -> true
        _ -> false
      end)
      |> Enum.map(&parse_tile/1)
      |> Enum.into(%{})

    sides =
      tiles
      |> Enum.flat_map(fn {id, border} ->
        Day20.Border.possible_sides(border)
        |> Enum.map(&{&1, id})
      end)
      |> Enum.reduce(%{}, fn {side, id}, map ->
        Map.update(map, side, [id], fn v -> [id | v] end)
      end)

    corners =
      tiles
      |> Enum.filter(fn t -> possible_corder?(t, sides) end)
      |> Enum.map(fn {id, _border} -> id end)

    case Enum.count(corners) do
      4 -> Enum.reduce(corners, &Kernel.*/2)
      _ -> "Found #{Enum.count(corners)} corners"
    end
  end

  def part_two(file_reader \\ InputFile) do
    tiles =
      file_reader.contents_of(20, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_by(fn s -> s == "" end)
      |> Enum.reject(fn
        [""] -> true
        _ -> false
      end)
      |> Enum.map(&parse_tile/1)
      |> Enum.into(%{})

    sides =
      tiles
      |> Enum.flat_map(fn {id, border} ->
        Day20.Border.possible_sides(border)
        |> Enum.map(&{&1, id})
      end)
      |> Enum.reduce(%{}, fn {side, id}, map ->
        Map.update(map, side, MapSet.new([id]), fn v -> MapSet.put(v, id) end)
      end)

    corners =
      tiles
      |> Enum.filter(fn t -> possible_corder?(t, sides) end)

    corner = orient(hd(corners), sides)
    width = tiles |> Enum.count() |> :math.sqrt() |> floor()

    cells =
      for y <- 0..(width - 1) do
        for x <- 0..(width - 1), do: {x, y}
      end
      |> Enum.concat()
      |> Enum.reject(&(&1 == {0, 0}))

    grid = build(%{{0, 0} => corner}, cells, tiles, sides)

    picture =
      for y <- 0..(width - 1) do
        for x <- 0..(width - 1) do
          {_id, border} = Map.get(grid, {x, y})
          border.image
        end
        |> Enum.zip()
        |> Enum.map(&Tuple.to_list/1)
        |> Enum.map(&Enum.join/1)
      end
      |> Enum.concat()

    waves =
      Enum.map(picture, fn row ->
        String.split(row, "", trim: true) |> Enum.count(&(&1 == "#"))
      end)
      |> Enum.reduce(&Kernel.+/2)

    monsters = count_sea_monsters(picture)

    waves - monsters * 15
  end

  def build(picture, [], _tiles, _sides), do: picture

  def build(picture, [{x, 0} | rest], tiles, sides) do
    {id, border} = Map.get(picture, {x - 1, 0})
    edge = border.right
    tile_id = Map.get(sides, edge) |> MapSet.delete(id) |> MapSet.to_list() |> hd()
    tile = Map.get(tiles, tile_id) |> match(edge, :left)
    build(Map.put(picture, {x, 0}, {tile_id, tile}), rest, tiles, sides)
  end

  def build(picture, [{x, y} | rest], tiles, sides) do
    {id, border} = Map.get(picture, {x, y - 1})
    edge = border.bottom
    tile_id = Map.get(sides, edge) |> MapSet.delete(id) |> MapSet.to_list() |> hd()
    tile = Map.get(tiles, tile_id) |> match(edge, :top)
    build(Map.put(picture, {x, y}, {tile_id, tile}), rest, tiles, sides)
  end

  def match(border, edge, :left) do
    cond do
      border.left == edge -> border
      Day20.Border.flip(border).left == edge -> Day20.Border.flip(border)
      true -> match(Day20.Border.rotate(border), edge, :left)
    end
  end

  def match(border, edge, :top) do
    cond do
      border.top == edge -> border
      Day20.Border.flip(border).top == edge -> Day20.Border.flip(border)
      true -> match(Day20.Border.rotate(border), edge, :top)
    end
  end

  defp parse_tile([<<"Tile ", rest::binary>> | rows]) do
    {id, ":"} = Integer.parse(rest)

    {id, Day20.Border.parse(rows)}
  end

  defp possible_corder?({_id, border}, sides) do
    [border.top, border.right, border.bottom, border.left]
    |> Enum.reject(fn s -> Map.get(sides, s) |> Enum.count() > 1 end)
    |> Enum.count() == 2
  end

  def orient(corner, sides), do: orient(corner, sides, 0)
  def orient(_corner, _sides, 8), do: :error

  def orient({id, border}, sides, n) do
    case [border.right, border.bottom]
         |> Enum.all?(fn s -> Map.get(sides, s) |> Enum.count() == 2 end) do
      true -> {id, border}
      false -> orient({id, iterate(border, n)}, sides, n + 1)
    end
  end

  def iterate(border, 3), do: Day20.Border.flip(border) |> Day20.Border.rotate()
  def iterate(border, _n), do: Day20.Border.rotate(border)

  def count_sea_monsters(rows) do
    case do_count_sea_monsters(rows) do
      0 ->
        case do_count_sea_monsters(flip(rows)) do
          0 -> count_sea_monsters(rotate(rows))
          n -> n
        end

      n ->
        n
    end
  end

  def do_count_sea_monsters(rows) do
    rows
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [a, b, c] ->
      sea_monster_row_1_offsets(a)
      |> sea_monster_row_2_offsets(b)
      |> sea_monster_row_3_offsets(c)
      |> Enum.count()
    end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def sea_monster_row_1_offsets(row) do
    row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.filter(fn {c, _} -> c == "#" end)
    |> Enum.map(fn {_c, i} -> i - 18 end)
    |> Enum.filter(&(&1 >= 0))
  end

  def sea_monster_row_2_offsets(offsets, row) do
    offsets
    |> Enum.filter(fn o ->
      [0, 5, 6, 11, 12, 17, 18, 19] |> Enum.all?(fn i -> String.at(row, o + i) == "#" end)
    end)
  end

  def sea_monster_row_3_offsets(offsets, row) do
    offsets
    |> Enum.filter(fn o ->
      [1, 4, 7, 10, 13, 16] |> Enum.all?(fn i -> String.at(row, o + i) == "#" end)
    end)
  end

  def flip(picture) do
    Enum.map(picture, &String.reverse/1)
  end

  def rotate(picture) do
    picture
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&Enum.join/1)
  end
end
