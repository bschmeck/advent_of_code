defmodule Day01Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day01.part_one(InputTestFile) == 11
  end

  test "it can solve part two" do
    assert Day01.part_two(InputTestFile) == 31
  end
end
