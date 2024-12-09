defmodule Day08 do
  def part_one(input \\ InputFile) do
    lines = input.contents_of(8) |> String.split("\n", trim: true)

    width = hd(lines) |> String.split("", trim: true) |> Enum.count()
    height = Enum.count(lines)

    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, map ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(map, fn
        {".", _x}, m -> m
        {freq, x}, m -> Map.update(m, freq, [{x, y}], fn pts -> [{x, y} | pts] end)
      end)
    end)
    |> Enum.flat_map(&(antinodes(&1, width, height)))
    |> Enum.into(MapSet.new())
    |> Enum.count()
  end

  def part_two(input \\ InputFile) do
    lines = input.contents_of(8) |> String.split("\n", trim: true)

    width = hd(lines) |> String.split("", trim: true) |> Enum.count()
    height = Enum.count(lines)

    lines
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, y}, map ->
      String.split(row, "", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(map, fn
        {".", _x}, m -> m
        {freq, x}, m -> Map.update(m, freq, [{x, y}], fn pts -> [{x, y} | pts] end)
      end)
    end)
    |> Enum.flat_map(&(antinodes2(&1, width, height)))
    |> Enum.into(MapSet.new())
    |> Enum.count()
  end

  def antinodes({_freq, [_point]}, _w, _h), do: []
  def antinodes({_freq, points}, w, h) do
    points
    |> pairs([])
    |> Enum.flat_map(fn {{x1, y1}, {x2, y2}} -> [{2 * x1 - x2, 2 * y1 - y2}, {2 * x2 - x1, 2 * y2 - y1}] end)
    |> Enum.reject(fn {x, y} -> x < 0 || x >= w || y < 0 || y >= h end)
  end

  def antinodes2({_freq, [p]}, _w, _h), do: [p]
  def antinodes2({_freq, points}, w, h) do
    points
    |> pairs([])
    |> Enum.flat_map(fn {p1, p2} -> points(p1, p2, w, h) ++ points(p2, p1, w, h) end)
  end

  def points({x1, y1}, {x2, y2}, w, h) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(fn i -> {(i + 1) * x1 - i * x2, (i + 1) * y1 - i * y2} end)
    |> Stream.take_while(fn {x, y} -> (x >= 0 && x < w) && (y >= 0 && y < h) end)
    |> Enum.to_list()
  end

  def pairs([_pt], acc), do: acc
  def pairs([pt | rest], acc) do
    pairs(rest, Enum.map(rest, &({pt, &1})) ++ acc)
  end
end
