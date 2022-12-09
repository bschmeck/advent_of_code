defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day09.part_one(InputTestFile) == 13
  end

  test "it can solve part two" do
    assert Day09.part_two(InputTestFile) == 1
  end

  test "it doesn't change points that are on top of each other" do
    assert Day09.adjust_knots({3, 4}, {3, 4}) == {3, 4}
  end

  test "it doesn't change when the tail is to the left" do
    assert Day09.adjust_knots({3, 4}, {2, 4}) == {2, 4}
  end

  test "it doesn't change when the tail is to the right" do
    assert Day09.adjust_knots({3, 4}, {4, 4}) == {4, 4}
  end

  test "it doesn't change when the tail is above" do
    assert Day09.adjust_knots({3, 4}, {3, 3}) == {3, 3}
  end

  test "it doesn't change when the tail is below" do
    assert Day09.adjust_knots({3, 4}, {3, 5}) == {3, 5}
  end

  test "it doesn't change when the tail is diagonally adjacent" do
    assert Day09.adjust_knots({3, 4}, {2, 3}) == {2, 3}
  end

  test "it closes the gap when the tail is too far left" do
    assert Day09.adjust_knots({3, 4}, {1, 4}) == {2, 4}
  end

  test "it closes the gap when the tail is too far rightt" do
    assert Day09.adjust_knots({3, 4}, {5, 4}) == {4, 4}
  end

  test "it closes the gap when the tail is too far above" do
    assert Day09.adjust_knots({3, 4}, {3, 2}) == {3, 3}
  end

  test "it closes the gap when the tail is too far below" do
    assert Day09.adjust_knots({3, 4}, {3, 6}) == {3, 5}
  end

  test "it closes the gap when the tail is too far away diagonally" do
    assert Day09.adjust_knots({3, 4}, {2, 6}) == {3, 5}
    assert Day09.adjust_knots({3, 4}, {4, 6}) == {3, 5}
    assert Day09.adjust_knots({3, 4}, {2, 2}) == {3, 3}
    assert Day09.adjust_knots({3, 4}, {4, 2}) == {3, 3}
    assert Day09.adjust_knots({2, 2}, {0, 0}) == {1, 1}
    assert Day09.adjust_knots({-2, 2}, {0, 0}) == {-1, 1}
  end
end
