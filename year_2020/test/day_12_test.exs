defmodule Day12Test do
  use ExUnit.Case

  test "it computes the manhattan distance" do
    assert Day12.part_one(InputTestFile) == 25
  end
end
