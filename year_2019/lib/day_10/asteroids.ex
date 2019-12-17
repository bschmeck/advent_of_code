defmodule Day10.Asteroids do
  def run(1) do
    10
    |> InputFile.contents_of
    |> String.split("\n")
    |> Day10.Asteroids.parse
    |> Day10.Asteroids.counts
    |> Map.values
    |> Enum.max
    |> IO.puts
  end

  def parse(lines), do: parse(lines, 0, [])
  def parse([], _lnum, locs), do: locs
  def parse([line | rest], lnum, locs), do: parse(rest, lnum + 1, parse_line(line, lnum, 0, locs))
  def parse_line("", _lnum, _pos, locs), do: locs
  def parse_line("." <> rest, lnum, pos, locs), do: parse_line(rest, lnum, pos + 1, locs)
  def parse_line("#" <> rest, lnum, pos, locs), do: parse_line(rest, lnum, pos + 1, [{pos, lnum} | locs])

  def pairs([elt | rest]), do: pairs(elt, rest, rest, [])
  defp pairs(_elt, [], [], ret), do: ret
  defp pairs(_, [], [elt | rest], ret), do: pairs(elt, rest, rest, ret)
  defp pairs(elt, [p | rest], next, ret), do: pairs(elt, rest, next, [{elt, p} | ret])

  def counts(locations) do
    loc_set = MapSet.new(locations)
    locations |> Enum.sort |> pairs |> compute_counts(loc_set, %{})
  end

  defp compute_counts([], _locs, map), do: map
  defp compute_counts([{a, b} | rest], locs, map) do
    map = if blocked?(a, b, locs) do
       map
    else
      map
      |> Map.update(a, 1, &(&1 + 1))
      |> Map.update(b, 1, &(&1 + 1))
    end

    compute_counts(rest, locs, map)
  end

  def blocked?(a, b, locs) do
    Enum.any?(locs, fn (loc) ->
      a < loc
      && loc < b
      && func_for(a, b).(loc)
    end)
  end

  def func_for({b_x, _b_y}, {a_x, _a_y}) when a_x == b_x do
    fn ({x, _y}) -> x == a_x end
  end
  def func_for({b_x, b_y}, {a_x, a_y}) do
    # Line from base to asteroid has slope:
    m = (a_y - b_y) / (a_x - b_x)
    # and intercept:
    b = a_y - m * a_x
    fn({x, y}) -> Float.round(m * x + b, 5) == y end
  end
end
