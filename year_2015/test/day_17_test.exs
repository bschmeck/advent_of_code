defmodule Day17Test do
  use ExUnit.Case, async: true

  test "it computes way to fill the containers" do
    assert Day17.part_one(InputTestFile, 25) == 4
  end

  test "it computes ways to use the fewest containers" do
    assert Day17.part_two(InputTestFile, 25) == 3
  end
end
