defmodule Day12.ShipTest do
  use ExUnit.Case, async: true

  test "it rotates the ship" do
    assert Day12.Ship.rotate(%Day12.Ship{}, -90).dir == 0
  end

  test "it mods by 360" do
    assert Day12.Ship.rotate(%Day12.Ship{dir: 270}, 90).dir == 0
  end
end
