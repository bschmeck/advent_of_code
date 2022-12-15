defmodule Day14Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day14.part_one(InputTestFile) == 24
  end

  test "it can solve part two" do
    assert Day14.part_two(InputTestFile) == 93
  end

  test "it converts a path to a set of points" do
    assert Day14.path("498,4 -> 498,6 -> 496,6") == MapSet.new([{498, 4}, {498, 5}, {498, 6}, {497, 6}, {496, 6}])
  end
end
