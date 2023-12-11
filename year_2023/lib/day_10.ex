defmodule Day10 do
  def part_one(input \\ InputFile) do
    tiles = input.contents_of(10, :stream)
    |> Enum.map(fn row -> String.split(row, "", trim: true) end)
    |> Grid.build()

    tiles.map
    |> Enum.find(fn {_point, char} -> char == "S" end)
    |> count_loop(tiles, 0, [nil])
    |> div(2)
  end

  def part_two(_input \\ InputFile) do

  end

  def count_loop({_point, "S"}, _tiles, length, _path) when length > 0, do: length
  def count_loop(tile, tiles, length, path), do: tile |> next_tile(hd(path), tiles) |> count_loop(tiles, length + 1, [tile | path])

  def next_tile({{x, y}, "S"}, _prev, tiles) do
    [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}]
    |> Enum.map(fn point -> {point, Map.get(tiles.map, point)} end)
    |> Enum.find(fn
      {{x2, ^y}, char} when x2 == x + 1 -> char in ["-", "7", "J"]
      {{x2, ^y}, char} when x2 == x - 1 -> char in ["-", "L", "F"]
      {{^x, y2}, char} when y2 == y + 1 -> char in ["|", "J", "L"]
      {{^x, y2}, char} when y2 == y - 1 -> char in ["|", "7", "F"]
    end)
  end

  def next_tile({{x, y}, pipe}, {{prev_x, prev_y}, _}, tiles) do
    dir = case {x - prev_x, y - prev_y} do
            {1, 0} -> :left
            {-1, 0} -> :right
            {0, 1} -> :top
            {0, -1} -> :bottom
          end
    loc = next_loc({x, y}, pipe, dir)

    pipe = Map.get(tiles.map, loc)

    {loc, pipe}
  end

  def next_loc({x, y}, "L", :top), do: {x + 1, y}
  def next_loc({x, y}, "L", :right), do: {x, y - 1}
  def next_loc({x, y}, "|", :top), do: {x, y + 1}
  def next_loc({x, y}, "|", :bottom), do: {x, y - 1}
  def next_loc({x, y}, "J", :left), do: {x, y - 1}
  def next_loc({x, y}, "J", :top), do: {x - 1, y}
  def next_loc({x, y}, "7", :bottom), do: {x - 1, y}
  def next_loc({x, y}, "7", :left), do: {x, y + 1}
  def next_loc({x, y}, "F", :right), do: {x, y + 1}
  def next_loc({x, y}, "F", :bottom), do: {x + 1, y}
  def next_loc({x, y}, "-", :right), do: {x - 1, y}
  def next_loc({x, y}, "-", :left), do: {x + 1, y}
end
