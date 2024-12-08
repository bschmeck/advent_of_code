defmodule Day07Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day07.part_one(InputTestFile) == 3749
  end

  test "it can solve part two" do
    assert Day07.part_two(InputTestFile) == 11387
  end
end
