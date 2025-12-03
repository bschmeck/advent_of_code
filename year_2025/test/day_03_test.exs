defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day03.part_one(InputTestFile) == 357
  end

  test "it can solve part two" do
    assert Day03.part_two(InputTestFile) == 3121910778619
  end

  test "it can find the one digit joltage of a list" do
    assert Day03.joltage([9, 8, 7, 6], 1) == 9
    assert Day03.joltage([1, 2, 3, 2], 1) == 3
    assert Day03.joltage([1, 2, 3, 4], 1) == 4
  end

  test "it can find the two digit joltage of a list" do
    assert Day03.joltage([9, 8, 7, 6], 2) == 98
    assert Day03.joltage([1, 2, 3, 2], 2) == 32
    assert Day03.joltage([1, 2, 3, 4], 2) == 34
  end

  test "it can find the 12 digit joltage of a list" do
    assert Day03.joltage([9,8,7,6,5,4,3,2,1,1,1,1,1,1,1], 12) == 987654321111
    assert Day03.joltage([8,1,1,1,1,1,1,1,1,1,1,1,1,1,9], 12) == 811111111119
    assert Day03.joltage([2,3,4,2,3,4,2,3,4,2,3,4,2,7,8], 12) == 434234234278
    assert Day03.joltage([8,1,8,1,8,1,9,1,1,1,1,2,1,1,1], 12) == 888911112111
  end
end
