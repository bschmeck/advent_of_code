defmodule Day20Test do
  use ExUnit.Case

  test "it computes the answer from the tiles" do
    assert Day20.part_one(InputTestFile) == 20_899_048_083_289
  end

  test "it counts non-sea monster waves" do
    assert Day20.part_two(InputTestFile) == 273
  end
end
