defmodule Day02Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day02.part_one(InputTestFile) == 2
  end

  @tag :skip
  test "it can solve part two" do
    assert Day02.part_two(InputTestFile) == nil
  end

  test "an increasing array is valid" do
    assert Day02.valid?([1, 2, 3])
  end

  test "a decreasing array is valid" do
    assert Day02.valid?([3, 2, 1])
  end

  test "an array that increases and decreases is not valid" do
    refute Day02.valid?([3, 2, 1, 2])
  end

  test "an array that plateaus is not valid" do
    refute Day02.valid?([3, 2, 2, 1])
  end

  test "an array that decreases more than 3 at a time is not valid" do
    refute Day02.valid?([6, 2, 1])
  end

  test "an array that increases more than 3 at a time is not valid" do
    refute Day02.valid?([1, 2, 6])
  end
end
