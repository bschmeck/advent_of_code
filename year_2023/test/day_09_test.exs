defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day09.part_one(InputTestFile) == 114
  end

  test "it can solve part two" do
    assert Day09.part_two(InputTestFile) == 2
  end

  test "it can find the next value for a series" do
    assert Day09.next_in("0 3 6 9 12 15") == 18
    assert Day09.next_in("1 3 6 10 15 21") == 28
    assert Day09.next_in("10 13 16 21 30 45") == 68
  end

  test "it can compute deltas between numbers" do
    assert Day09.deltas([0, 3, 6, 9, 12, 15]) == [3, 3, 3, 3, 3]
  end

  test "it can find the previous value for a series" do
    assert Day09.prev_in("0 3 6 9 12 15") == -3
    assert Day09.prev_in("1 3 6 10 15 21") == 0
    assert Day09.prev_in("10 13 16 21 30 45") == 5
  end
end
