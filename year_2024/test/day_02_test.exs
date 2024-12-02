defmodule Day02Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day02.part_one(InputTestFile) == 2
  end

  test "it can solve part two" do
    assert Day02.part_two(InputTestFile) == 4
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

  test "removing one value can make an array valid" do
    assert Day02.valid_with_dampening?([1, 3, 2, 4, 5])
    assert Day02.valid_with_dampening?([8, 6, 4, 4, 1])
    assert Day02.valid_with_dampening?([3, 3, 4, 5, 7])
  end

  test "multiple identical values cannot be dampened" do
    refute Day02.valid_with_dampening?([3, 3, 3, 4, 5])
  end

  test "dampening the final element works" do
    assert Day02.valid_with_dampening?([38, 41, 44, 47, 50, 48])
  end

  test "it can swith from increasing to decreasing with dampening" do
    assert Day02.valid_with_dampening?([2, 3, 2, 1])
  end

  test "it can switch from descreasing to increasing with dampening" do
    assert Day02.valid_with_dampening?([2, 1, 2, 3])
    assert Day02.valid_with_dampening?([4, 1, 5, 6, 9])
  end

  test "it checks" do
    assert Day02.valid_with_dampening?([1, 2, 5, 4, 5])
  end
end
