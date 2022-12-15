defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day15.part_one(InputTestFile, 10) == 26
  end

  @tag :skip
  test "it can solve part two" do
    assert Day15.part_two(InputTestFile) == nil
  end

  test "it returns no points when the target is too far away" do
    assert Day15.coverage({3, 4}, {4, 5}, 10) == MapSet.new()
  end

  test "it returns reachable points at the target line" do
    assert Day15.coverage({3, 4}, {3, 12}, 10) == MapSet.new([{3, 10}, {2, 10}, {4, 10}, {1, 10}, {5, 10}])
  end
end
