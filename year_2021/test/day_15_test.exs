defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it finds the risk of the safest route" do
    assert Day15.part_one(InputTestFile) == 40
  end
end
