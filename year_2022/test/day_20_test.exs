defmodule Day20Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day20.part_one(InputTestFile) == 3
  end

  @tag :skip
  test "it can solve part two" do
    assert Day20.part_two(InputTestFile) == nil
  end

  test "it can move an element in the list" do
    assert Day20.move([1, 2, -3, 3, -2, 0, 4], 1) == [2, 1, -3, 3, -2, 0, 4]
    assert Day20.move([1, -3, 2, 3, -2, 0, 4], -3) == [1, 2, 3, -2, -3, 0, 4]
    assert Day20.move([1, 2, -3, 0, 3, 4, -2], 4) == [1, 2, -3, 4, 0, 3, -2]
    assert Day20.move([1, 2, -2, -3, 0, 3, 4], -2) == [1, 2, -3, 0, 3, 4, -2]
    assert Day20.move([4, -2, 5, 6, 7, 8, 9], -2) == [4, 5, 6, 7, 8, -2, 9]
    assert Day20.move([10, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11], 10) == [2, 3, 4, 5, 6, 7, 8, 9, 1, 11, 10]
    assert Day20.move([100, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11], 100) == [2, 3, 4, 5, 6, 7, 8, 9, 1, 11, 100]
    assert Day20.move([101, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11], 101) == [2, 101, 3, 4, 5, 6, 7, 8, 9, 1, 11]
    assert Day20.move([-101, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11], -101) == [2, 3, 4, 5, 6, 7, 8, 9, 1, -101, 11]
    assert Day20.move([18, 2, 3, 4, 5, 6, 7, 8, 9, 1, 11], 18) == [2, 3, 4, 5, 6, 7, 8, 9, 18, 1, 11]
  end
end
