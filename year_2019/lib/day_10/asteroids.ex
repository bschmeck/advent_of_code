defmodule Day10.Asteroids do
  def run(1) do
    10
    |> InputFile.contents_of
    |> String.split("\n")
    |> Day10.Asteroids.parse
    |> Day10.Asteroids.counts
    |> Enum.map(fn({loc, set}) -> {MapSet.size(set), loc} end)
    |> Enum.max
    |> IO.puts
  end

  def run(2) do
    10
    |> InputFile.contents_of
    |> String.split("\n")
    |> Day10.Asteroids.parse
    |> Day10.Asteroids.vaporize({22, 25}, 200)
    |> IO.inspect
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

  def vaporize(locations, origin, n) do
    map = coord_map(origin, locations, %{})
    angles = Map.keys(map) |> Enum.sort |> Enum.reverse
    do_vaporize(angles, [], map, n)
  end

  defp do_vaporize([], next, map, n), do: do_vaporize(Enum.reverse(next), [], map, n)
  defp do_vaporize([angle | rest], next, map, n) do
    case Map.get(map, angle) do
      [] -> do_vaporize(rest, next, map, n)
      [{_distance, point} | asteroids] ->
        if n == 1 do
          point
        else
          map = Map.put(map, angle, asteroids)
          do_vaporize(rest, [angle | next], map, n - 1)
        end
    end
  end

  def coord_map(_origin, [], map), do: map
  def coord_map(origin, [origin | rest], map), do: coord_map(origin, rest, map)
  def coord_map(origin, [p | rest], map) do
    {angle, distance} = coords_of(origin, p)
    l = [{distance, p} | Map.get(map, angle, [])] |> Enum.sort

    coord_map(origin, rest, Map.put(map, angle, l))
  end
  def coords_of({o_x, o_y} = origin, {p_x, p_y} = point) do
    {
      angle_of(origin, point),
      :math.sqrt(:math.pow(p_x - o_x, 2) + :math.pow(p_y - o_y, 2))
    }
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
