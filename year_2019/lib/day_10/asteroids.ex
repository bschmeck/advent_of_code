defmodule Day10.Asteroids do
  def run(1) do
    10
    |> InputFile.contents_of
    |> String.split("\n")
    |> Day10.Asteroids.parse
    |> Day10.Asteroids.counts
    |> Map.values
    |> Enum.map(&(MapSet.size(&1)))
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
    locations |> Enum.sort |> pairs |> compute_counts(%{})
  end

  defp compute_counts([], map), do: map
  defp compute_counts([{a, b} | rest], map) do
    a_to_b = angle_of(a, b)
    b_to_a = angle_of(b, a)
    map = map
    |> Map.update(a, MapSet.new([a_to_b]), &(MapSet.put(&1, a_to_b)))
    |> Map.update(b, MapSet.new([b_to_a]), &(MapSet.put(&1, b_to_a)))

    compute_counts(rest, map)
  end

  defp angle_of({origin_x, origin_y}, {p_x, p_y}) do
    ElixirMath.atan2(p_x - origin_x, p_y - origin_y)
  end
end
