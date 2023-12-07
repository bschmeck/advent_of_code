defmodule Day07Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day07.part_one(InputTestFile) == 6440
  end

  @tag :skip
  test "it can solve part two" do
    assert Day07.part_two(InputTestFile) == nil
  end

  test "it can recognize ranks" do
    assert Day07.Hand.rank([13, 13, 13, 13, 13]) == 7
    assert Day07.Hand.rank([13, 13, 8, 13, 13]) == 6
    assert Day07.Hand.rank([2, 3, 3, 3, 2]) == 5
    assert Day07.Hand.rank([10, 10, 10, 9, 8]) == 4
    assert Day07.Hand.rank([2, 3, 4, 3, 2]) == 3
    assert Day07.Hand.rank([13, 2, 3, 13, 4]) == 2
    assert Day07.Hand.rank([2, 3, 4, 5, 6]) == 1
  end

  test "it can compare hands" do
    h1 = Day07.Hand.build("3AAAA 12")
    h2 = Day07.Hand.build("23456 77")

    assert Day07.Hand.cmp(h1, h2) > 0
    assert Day07.Hand.cmp(h2, h1) < 0
  end

  test "it can break ties by looking at the first card" do
    h1 = Day07.Hand.build("7AAAA 12")
    h2 = Day07.Hand.build("3AAAA 77")

    assert Day07.Hand.cmp(h1, h2) > 0
    assert Day07.Hand.cmp(h2, h1) < 0
  end
end
