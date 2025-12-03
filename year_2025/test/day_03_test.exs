defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day03.part_one(InputTestFile) == 357
  end

  @tag :skip
  test "it can solve part two" do
    assert Day03.part_two(InputTestFile) == nil
  end

  test "it can find the joltage of a list" do
    assert Day03.joltage([9, 8, 7, 6]) == 98
    assert Day03.joltage([1, 2, 3, 2]) == 32
  end
end
