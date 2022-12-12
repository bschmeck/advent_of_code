defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day11.part_one(InputTestFile) == 10_605
  end

  @tag :skip
  test "it can solve part two" do
    assert Day11.part_two(InputTestFile) == nil
  end
end
