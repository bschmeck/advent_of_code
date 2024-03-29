defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day13.part_one(InputTestFile) == 13
  end

  test "it can solve part two" do
    assert Day13.part_two(InputTestFile) == 140
  end

  test "two integers are valid if the left one is smaller" do
    assert Day13.valid?(1, 3)
  end

  test "two integers are not valid if the left one is larger" do
    refute Day13.valid?(7, 3)
  end

  test "two lists are valid if the left one runs out of elements first" do
    assert Day13.valid?([], [3])
  end

  test "two lists are not valid if the right one runs out of elements first" do
    refute Day13.valid?([13, 9], [])
  end

  test "it converts an integer to a list if needed" do
    assert Day13.valid?([1], [[3]])
    refute Day13.valid?([7], [[3]])
    assert Day13.valid?([[1]], [3])
    refute Day13.valid?([[7]], [3])
  end

  test "it handles nested lists" do
    left = [
      [[5, 1, [], [8, 1, 3], 6], ['\a']],
      [10, []],
      [6],
      [[], [[0, 6, 4, 10, 5], [2, 2, 9], [4, 4], [2, 10, 4, 10, 8]], 7, 7],
      [[5], 5, [[6], [8, 2], [5], []], [9, 3, 2, [9, 4, 8, 6, 8]]]
    ]
    right = [[5]]

    refute Day13.valid?(left, right)
  end

  test "it compares the lists from the example correctly" do
    left = [1, 1, 3, 1, 1]
    right = [1, 1, 5, 1, 1]
    assert Day13.valid?(left, right)

    left = [[1], [2, 3, 4]]
    right = [[1], 4]
    assert Day13.valid?(left, right)

    left = [9]
    right = [[8,7,6]]
    refute Day13.valid?(left, right)

    left = [[4,4],4,4]
    right = [[4,4],4,4,4]
    assert Day13.valid?(left, right)

    left = [7,7,7,7]
    right = [7,7,7]
    refute Day13.valid?(left, right)

    left = []
    right = [3]
    assert Day13.valid?(left, right)

    left = [[[]]]
    right = [[]]
    refute Day13.valid?(left, right)

    left = [1,[2,[3,[4,[5,6,7]]]],8,9]
    right = [1,[2,[3,[4,[5,6,0]]]],8,9]
    refute Day13.valid?(left, right)
  end
end
