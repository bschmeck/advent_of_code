defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day05.part_one(InputTestFile) == 143
  end

  test "it can solve part two" do
    assert Day05.part_two(InputTestFile) == 123
  end
end
