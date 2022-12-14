defmodule Day14Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day14.part_one(InputTestFile) == 24
  end

  @tag :skip
  test "it can solve part two" do
    assert Day14.part_two(InputTestFile) == nil
  end
end
