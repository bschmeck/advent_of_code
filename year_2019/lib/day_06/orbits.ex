defmodule Day06.Orbits do
  def parse(lines), do: parse(lines, %{})
  defp parse([], orbits), do: orbits
  defp parse([orbit | rest], orbits) do
    [from, to] = String.split(orbit, ")")
    orbits = Map.update(orbits, from, %{to: [to]}, fn(m) -> Map.update(m, :to, [to], fn(a) -> [to | a] end) end)
    orbits = Map.update(orbits, to, %{from: from}, fn(m) -> Map.put(m, :from, from) end)
    parse(rest, orbits)
  end

  def count(orbits), do: count(orbits, ["COM"], [], 1, 0)
  defp count(_, [], [], _, total), do: total
  defp count(orbits, [], next, length, total), do: count(orbits, next, [], length + 1, total)
  defp count(orbits, [obj | rest], next, length, total) do
    orbiters = orbits |> Map.get(obj, %{}) |> Map.get(:to, [])
    total = total + length * Enum.count(orbiters)
    next = next ++ orbiters
    count(orbits, rest, next, length, total)
  end

  def distance_to_santa(orbits) do
    you_orbit = orbits |> Map.get("YOU") |> Map.get(:from)
    santa_orbits = orbits |> Map.get("SAN") |> Map.get(:from)
    distance(orbits, MapSet.new([nil, "YOU", "SAN"]), [you_orbit], santa_orbits, [], 0)
  end

  defp distance(_orbits, _visited, [target | _rest], target, _next, hops), do: hops
  defp distance(orbits, visited, [], target, next, hops), do: distance(orbits, visited, next, target, [], hops + 1)
  defp distance(orbits, visited, [src | rest], target, next, hops) do
    links = links_from(orbits, src)
    new_nodes = MapSet.difference(links, visited)
    visited = MapSet.union(links, visited)
    next = next ++ Enum.into(new_nodes, [])
    distance(orbits, visited, rest, target, next, hops)
  end

  def links_from(orbits, obj) do
    data = Map.get(orbits, obj)
    [Map.get(data, :from) | Map.get(data, :to, [])] |> MapSet.new
  end

  def count_input() do
    InputFile.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.into([])
    |> parse
    |> count
    |> IO.puts
  end

  def run(:part2) do
    InputFile.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.into([])
    |> parse
    |> distance_to_santa
    |> IO.puts
  end
end
