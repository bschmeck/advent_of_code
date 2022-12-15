defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day15.part_one(InputTestFile, 10) == 26
  end

  test "it can solve part two" do
    assert Day15.part_two(InputTestFile, 20) == 56000011
  end

  test "it returns no points when the target is too far away" do
    assert Day15.coverage({3, 4}, {4, 5}, 10) == MapSet.new()
  end

  test "it returns reachable points at the target line" do
    assert Day15.coverage({3, 4}, {3, 12}, 10) == MapSet.new([{3, 10}, {2, 10}, {4, 10}, {1, 10}, {5, 10}])
  end

  test "returns the lines covered by a sensor" do
    assert Day15.lines({8,7}, {2, 10}, 20) == [{0, {6, 10}}, {1, {5, 11}}, {2, {4, 12}}, {3, {3, 13}}, {4, {2, 14}}, {5, {1, 15}}, {6, {0, 16}}, {7, {0, 17}}, {8, {0, 16}}, {9, {1, 15}}, {10, {2, 14}}, {11, {3, 13}}, {12, {4, 12}}, {13, {5, 11}}, {14, {6, 10}}, {15, {7, 9}}, {16, {8, 8}}]
  end

  test "it combines lines" do
    assert Day15.combine_line([{2, 2}], {11, 13}, []) == [{2, 2}, {11, 13}]
    assert Day15.combine_line([{2, 2}], {3, 7}, []) == [{2, 7}]
    assert Day15.combine_line([{2, 2}, {11, 13}], {3, 13}, []) == [{2, 13}]
    assert Day15.combine_line([{0, 4}], {4, 8}, []) == [{0, 8}]
    assert Day15.combine_line([{4, 6}, {9, 13}], {2, 18}, []) == [{2, 18}]
  end
end
