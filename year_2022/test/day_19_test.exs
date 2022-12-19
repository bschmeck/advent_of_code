defmodule Day19Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day19.part_one(InputTestFile) == 33
  end

  @tag :skip
  test "it can solve part two" do
    assert Day19.part_two(InputTestFile) == nil
  end
end
