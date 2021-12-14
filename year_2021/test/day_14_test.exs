defmodule Day14Test do
  use ExUnit.Case, async: true

  test "it computes the difference after 10 steps" do
    assert Day14.part_one(InputTestFile) == 1588
  end

  test "it computes the difference after 40 steps" do
    assert Day14.part_two(InputTestFile) == 2_188_189_693_529
  end
end
