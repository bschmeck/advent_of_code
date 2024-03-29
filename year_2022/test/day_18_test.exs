defmodule Day18Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day18.part_one(InputTestFile) == 64
  end

  @tag :skip
  test "it can solve part two" do
    assert Day18.part_two(InputTestFile) == nil
  end
end
