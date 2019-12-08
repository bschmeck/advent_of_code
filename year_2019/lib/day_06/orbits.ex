defmodule Day06.Orbits do
  def parse(lines), do: parse(lines, %{})
  defp parse([], orbits), do: orbits
  defp parse([orbit | rest], orbits) do
    [from, to] = String.split(orbit, ")")
    orbits = Map.update(orbits, from, [to], fn(a) -> [to | a] end)
    parse(rest, orbits)
  end

  def count(orbits), do: count(orbits, ["COM"], [], 1, 0)
  defp count(_, [], [], _, total), do: total
  defp count(orbits, [], next, length, total), do: count(orbits, next, [], length + 1, total)
  defp count(orbits, [obj | rest], next, length, total) do
    orbiters = Map.get(orbits, obj, [])
    total = total + length * Enum.count(orbiters)
    next = next ++ orbiters
    count(orbits, rest, next, length, total)
  end

  def count_input() do
    "#{__DIR__}/input.txt"
    |> File.stream!([], :line)
    |> Enum.map(&String.trim/1)
    |> Enum.into([])
    |> parse
    |> count
    |> IO.puts
  end
end
