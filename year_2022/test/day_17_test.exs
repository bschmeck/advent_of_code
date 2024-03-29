defmodule Day17Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day17.part_one(InputTestFile) == 3068
  end

  @tag :skip
  test "it can solve part two" do
    assert Day17.part_two(InputTestFile) == nil
  end
end
