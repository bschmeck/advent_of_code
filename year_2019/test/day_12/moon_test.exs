defmodule Day12.MoonTest do
  use ExUnit.Case

  test "it steps through movement" do
    moons = [
      Day12.Moon.at(-1, 0, 2),
      Day12.Moon.at(2, -10, -7),
      Day12.Moon.at(4, -8, 8),
      Day12.Moon.at(3, 5, -1)
    ] |> Day12.Moon.step(2) |> Enum.sort
    assert moons == [%Day12.Moon{position: Day12.Vector.new(5, -3, -1), velocity: Day12.Vector.new(3, -2, -2)},
                    %Day12.Moon{position: Day12.Vector.new(1, -2, 2), velocity: Day12.Vector.new(-2, 5, 6)},
                    %Day12.Moon{position: Day12.Vector.new(1, -4, -1), velocity: Day12.Vector.new(0, 3, -6)},
                    %Day12.Moon{position: Day12.Vector.new(1, -4, 2), velocity: Day12.Vector.new(-1, -6, 2)}
                   ] |> Enum.sort
  end

  test "it computes energy" do
    energy = [
      %Day12.Moon{position: Day12.Vector.new(8, -12, -9), velocity: Day12.Vector.new(-7, 3, 0)},
      %Day12.Moon{position: Day12.Vector.new(13, 16, -3), velocity: Day12.Vector.new(3, -11, -5)},
      %Day12.Moon{position: Day12.Vector.new(-29, -11, -1), velocity: Day12.Vector.new(-3, 7, 4)},
      %Day12.Moon{position: Day12.Vector.new(16, -13, 23), velocity: Day12.Vector.new(7, 1, 1)}
    ] |> Day12.Moon.total_energy
    assert energy == 1940
  end
  test "moons attract each other" do
    ganymede = Day12.Moon.at(3, 1, 8)
    callisto = Day12.Moon.at(5, 1, 8)

    ganymede = Day12.Moon.gravitate(ganymede, callisto)
    assert ganymede.velocity == %Day12.Vector{x: 1, y: 0, z: 0}
    callisto = Day12.Moon.gravitate(callisto, ganymede)
    assert callisto.velocity == %Day12.Vector{x: -1, y: 0, z: 0}
  end

  test "moons move with their velocity" do
    europa = %Day12.Moon{position: %Day12.Vector{x: 1, y: 2, z: 3}, velocity: %Day12.Vector{x: -2, y: 0, z: 3}} |> Day12.Moon.move

    assert europa.position == %Day12.Vector{x: -1, y: 2, z: 6}
  end
end
