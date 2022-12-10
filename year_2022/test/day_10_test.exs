defmodule Day10Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day10.part_one(InputTestFile) == 13_140
  end

  @tag :skip
  test "it can solve part two" do
    # Day10.part_two(InputTestFile) == nil
  end
end
