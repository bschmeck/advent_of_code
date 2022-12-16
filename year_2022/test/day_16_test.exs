defmodule Day16Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day16.part_one(InputTestFile) == 1651
  end

  @tag :skip
  test "it can solve part two" do
    assert Day16.part_two(InputTestFile) == nil
  end
end
