defmodule Day06Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day06.part_one(InputTestFile) == 41
  end

  @tag :skip
  test "it can solve part two" do
    assert Day06.part_two(InputTestFile) == nil
  end

  test "it can advance the guard upwards into an open space" do
    grid = %Grid{width: 5, height: 5, map: %{{1, 1} => "."}}
    state = {{1, 2}, {0, -1}}
    assert Day06.step(state, grid) == {{1, 1}, {0, -1}}
  end

  test "it can advance the guard downwards into an open space" do
    grid = %Grid{width: 5, height: 5, map: %{{1, 1} => "."}}
    state = {{1, 0}, {0, 1}}
    assert Day06.step(state, grid) == {{1, 1}, {0, 1}}
  end

  test "it can advance the guard rightwards into an open space" do
    grid = %Grid{width: 5, height: 5, map: %{{1, 1} => "."}}
    state = {{0, 1}, {1, 0}}
    assert Day06.step(state, grid) == {{1, 1}, {1, 0}}
  end

  test "it can advance the guard leftwards into an open space" do
    grid = %Grid{width: 5, height: 5, map: %{{1, 1} => "."}}
    state = {{2, 1}, {-1, 0}}
    assert Day06.step(state, grid) == {{1, 1}, {-1, 0}}
  end

  test "it can rotate the guard 90 degrees when blocked" do
    grid = %Grid{width: 5, height: 5, map: %{{1, 1} => "#"}}
    state = {{2, 1}, {-1, 0}}
    assert Day06.step(state, grid) == {{2, 1}, {0, -1}}
  end
end
