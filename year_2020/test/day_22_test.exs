defmodule Day22Test do
  use ExUnit.Case

  test "it computes the final score of the game" do
    assert Day22.part_one(InputTestFile) == 306
  end

  test "it computes the final score of the recursive game" do
    assert abs(Day22.part_two(InputTestFile)) == 291
  end
end
