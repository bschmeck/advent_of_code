defmodule Day13Test do
  use ExUnit.Case

  test "it computes maximum change in happiness" do
    assert Day13.part_one(InputTestFile) == 330
  end
end
