defmodule Day02Test do
  use ExUnit.Case, async: true

  test "part_one sums the total score" do
    assert Day02.part_one(InputTestFile) == 15
  end

  test "part_two chooses each shape and sums the total score" do
    assert Day02.part_two(InputTestFile) == 12
  end
end
