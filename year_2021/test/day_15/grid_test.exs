defmodule Day15.GridTest do
  use ExUnit.Case, async: true

  test "it returns risk at points outside the main grid" do
    grid = Day15.Grid.new(InputTestFile, 5)
    assert Day15.Grid.risk_at(grid, {2, 1}) == 8
    assert Day15.Grid.risk_at(grid, {12, 1}) == 9
    assert Day15.Grid.risk_at(grid, {22, 1}) == 1
    assert Day15.Grid.risk_at(grid, {32, 1}) == 2
    assert Day15.Grid.risk_at(grid, {42, 1}) == 3
    assert Day15.Grid.risk_at(grid, {2, 11}) == 9
    assert Day15.Grid.risk_at(grid, {12, 11}) == 1
    assert Day15.Grid.risk_at(grid, {22, 11}) == 2
    assert Day15.Grid.risk_at(grid, {32, 11}) == 3
    assert Day15.Grid.risk_at(grid, {42, 11}) == 4
    assert Day15.Grid.risk_at(grid, {42, 41}) == 7
  end
end
