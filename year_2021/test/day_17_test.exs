defmodule Day17Test do
  use ExUnit.Case, async: true

  test "it computes maximum height" do
    assert Day17.part_one(InputTestFile) == 45
  end

  test "it computes the number of possible velocities" do
    assert Day17.part_two(InputTestFile) == 112
  end
end
