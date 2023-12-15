defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day15.part_one(InputTestFile) == 1320
  end

  @tag :skip
  test "it can solve part two" do
    assert Day15.part_two(InputTestFile) == nil
  end

  test "it can hash a string" do
    assert Day15.hash("HASH") == 52
  end
end
