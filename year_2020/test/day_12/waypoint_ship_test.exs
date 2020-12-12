defmodule Day12.WaypointShipTest do
  use ExUnit.Case, async: true

  test "it rotates right by 90" do
    rotated = Day12.WaypointShip.rotate(%Day12.WaypointShip{wx: 10, wy: 4}, 90)
    assert rotated.wx == 4
    assert rotated.wy == -10
  end
end
