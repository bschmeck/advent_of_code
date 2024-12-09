defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day08.part_one(InputTestFile) == 14
  end

  test "it can solve part two" do
    assert Day08.part_two(InputTestFile) == 34
  end

  test "it can compute pairs" do
    assert Day08.pairs([1, 2, 3, 4], []) |> Enum.sort() == [{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}]
  end

  test "it can find points in the grid" do
    assert Day08.points({2, 2}, {3, 3}, 5, 5) |> Enum.sort == [{0, 0}, {1, 1}, {2, 2}]
  end
end
