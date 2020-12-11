defmodule Day11Test do
  use ExUnit.Case

  test "it counts occupied seats after stabilizing" do
    assert Day11.part_one(InputTestFile) == 37
  end

  test "it counts occupied seats after stabilizing v2" do
    assert Day11.part_two(InputTestFile) == 26
  end
end
