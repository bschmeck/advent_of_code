defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day15.part_one(InputTestFile) == 26
  end

  @tag :skip
  test "it can solve part two" do
    assert Day15.part_two(InputTestFile) == nil
  end
end
