defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it computes the shortest distance" do
    assert Day09.part_one(InputTestFile) == 605
  end

  test "it computes the longest distance" do
    assert Day09.part_two(InputTestFile) == 982
  end
end
