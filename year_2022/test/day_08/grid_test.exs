defmodule Day08.GridTest do
  use ExUnit.Case

  test "it can build a map" do
    grid = Day08.Grid.build([[1, 2], [3, 4]])
    assert grid.map == %{{0, 0} => 1, {1, 0} => 2, {0, 1} => 3, {1, 1} => 4}
  end

  test "it stores a grid's width" do
    grid = Day08.Grid.build([[1, 2, 2], [3, 4, 4]])
    assert grid.width == 3
  end

  test "it stores a grid's height" do
    grid = Day08.Grid.build([[1, 2], [3, 4], [5, 6], [7, 8]])
    assert grid.height == 4
  end

  test "it provides all points in a row" do
    grid = Day08.Grid.build([[1, 2, 2], [3, 4, 4]])
    assert Day08.Grid.row(grid, 0) == [{0, 0}, {1, 0}, {2, 0}]
  end
  test "it provides all points in a column" do
    grid = Day08.Grid.build([[1, 2], [3, 4], [5, 6], [7, 8]])
    assert Day08.Grid.col(grid, 1) == [{1, 0}, {1, 1}, {1, 2}, {1, 3}]
  end
end
