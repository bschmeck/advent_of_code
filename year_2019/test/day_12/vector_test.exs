defmodule Day12.VectorTest do
  use ExUnit.Case

  test "it can adjust vectors" do
    adj = Day12.Vector.adjust(%Day12.Vector{x: 5, y: 6, z: 7}, %Day12.Vector{x: 1, y: -1, z: 1})
    assert adj.x == 6
    assert adj.y == 5
    assert adj.z == 8
  end

  test "it can invert vectors" do
    inverted = Day12.Vector.invert(%Day12.Vector{x: 1, y: -1, z: 12})
    assert inverted.x == -1
    assert inverted.y == 1
    assert inverted.z == -12
  end
end
