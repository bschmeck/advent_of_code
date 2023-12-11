defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day11.part_one(InputTestFile) == 374
  end

  @tag :skip
  test "it can solve part two" do
    assert Day11.part_two(InputTestFile) == nil
  end

  test "it can compute the distance between points" do
    assert Day11.distance({4, 0}, {9, 10}) == 15
    assert Day11.distance({9, 10}, {4, 0}) == 15
    assert Day11.distance({1, 6}, {5, 11}) == 9
    assert Day11.distance({5, 11}, {1, 6}) == 9
  end

  test "it can expand the universe" do
    universe = [{3, 0}, {7, 1}, {0, 2}, {6, 4}, {1, 5}, {9, 6}, {7, 8}, {0, 9}, {4, 9}]
    expanded = universe |> Day11.expand() |> Enum.sort()

    assert expanded == [{0, 2}, {0, 11}, {1, 6}, {4, 0}, {5, 11}, {8, 5}, {9, 1}, {9, 10}, {12, 7}]
  end
end
