defmodule Day06.OrbitsTest do
  use ExUnit.Case

  test "it parses a list of orbits" do
    orbits = Day06.Orbits.parse(lines())
    assert Map.get(orbits, "COM") == %{to: ["B"]}
    assert Map.get(orbits, "B") == %{to: ["G", "C"], from: "COM"}
    assert Map.get(orbits, "C") == %{to: ["D"], from: "B"}
    assert Map.get(orbits, "D") == %{to: ["I", "E"], from: "C"}
    assert Map.get(orbits, "E") == %{to: ["J", "F"], from: "D"}
    assert Map.get(orbits, "F") == %{from: "E"}
    assert Map.get(orbits, "G") == %{to: ["H"], from: "B"}
    assert Map.get(orbits, "H") == %{from: "G"}
    assert Map.get(orbits, "I") == %{from: "D"}
    assert Map.get(orbits, "J") == %{to: ["K"], from: "E"}
    assert Map.get(orbits, "K") == %{to: ["L"], from: "J"}
    assert Map.get(orbits, "L") == %{from: "K"}
  end

  test "it can figure out links" do
    orbits = Day06.Orbits.parse(lines())
    assert Day06.Orbits.links_from(orbits, "L") == MapSet.new(["K"])
  end
  test "it computes the total number of orbits" do
    assert lines() |> Day06.Orbits.parse |> Day06.Orbits.count == 42
  end

  test "it counts transfer distances of 0" do
    orbits = ["COM)B", "B)YOU", "B)SAN"] |> Day06.Orbits.parse
    assert Day06.Orbits.distance_to_santa(orbits) == 0
  end

  test "it counts transfer distances of 1" do
    orbits = ["COM)A", "A)B", "A)YOU", "B)SAN"] |> Day06.Orbits.parse
    assert Day06.Orbits.distance_to_santa(orbits) == 1
  end

  test "it counts transfer distance between objects" do
    orbits = lines(:you) |> Day06.Orbits.parse
    assert Day06.Orbits.distance_to_santa(orbits) == 4
  end

  def lines, do: ~w{COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L}
  def lines(:you), do: ~w{COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L K)YOU I)SAN}
end
