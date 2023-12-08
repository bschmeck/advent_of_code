defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day08.part_one(InputTestFile) == 2
  end

  @tag :skip
  test "it can solve part two" do
    assert Day08.part_two(InputTestFile) == nil
  end
end
