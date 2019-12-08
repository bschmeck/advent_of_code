defmodule Day06.OrbitsTest do
  use ExUnit.Case

  test "it parses a list of orbits" do
    orbits = Day06.Orbits.parse(lines())
    assert Map.get(orbits, "COM") == ["B"]
    assert Map.get(orbits, "B") == ["G", "C"]
    assert Map.get(orbits, "C") == ["D"]
    assert Map.get(orbits, "D") == ["I", "E"]
    assert Map.get(orbits, "E") == ["J", "F"]
    assert Map.get(orbits, "G") == ["H"]
    assert Map.get(orbits, "J") == ["K"]
    assert Map.get(orbits, "K") == ["L"]
  end

  test "it computes the total number of orbits" do
    assert lines() |> Day06.Orbits.parse |> Day06.Orbits.count == 42
  end

  def lines, do: ~w{COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L}
end
