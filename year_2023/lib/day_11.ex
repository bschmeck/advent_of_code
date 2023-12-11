defmodule Day11 do
  def part_one(input \\ InputFile) do
    input.contents_of(11, :stream)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {char, _x} -> char == "#" end)
      |> Enum.map(fn {"#", x} -> {x, y} end)
    end)
    |> expand()
    |> pairs([])
    |> Enum.map(fn [pt1, pt2] -> distance(pt1, pt2) end)
    |> Enum.sum
  end

  def part_two(_input \\ InputFile) do

  end

  def distance({x1, y1}, {x2, y2}), do: abs(x2 - x1) + abs(y2 - y1)

  def expand(universe) do
    xs = universe |> Enum.map(fn {x, _y} -> x end) |> Enum.into(MapSet.new())
    ys = universe |> Enum.map(fn {_x, y} -> y end) |> Enum.into(MapSet.new())

    missing_x = (for x <- 0..(Enum.max(xs)), do: x) |> Enum.reject(fn x -> MapSet.member?(xs, x) end)
    missing_y = (for y <- 0..(Enum.max(ys)), do: y) |> Enum.reject(fn y -> MapSet.member?(ys, y) end)

    universe
    |> Enum.map(fn {x, y} -> {x + Enum.count(missing_x, fn x_m -> x_m < x end), y + Enum.count(missing_y, fn y_m -> y_m < y end)} end)
  end

  def pairs([_pt], all), do: all
  def pairs([pt | rest], all), do: pairs(rest, Enum.map(rest, fn pt2 -> [pt, pt2] end) ++ all)
end
