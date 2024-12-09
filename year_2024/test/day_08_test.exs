defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day08.part_one(InputTestFile) == 14
  end

  @tag :skip
  test "it can solve part two" do
    assert Day08.part_two(InputTestFile) == nil
  end

  test "it can compute pairs" do
    assert Day08.pairs([1, 2, 3, 4], []) |> Enum.sort() == [{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}]
  end
end
