defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it counts dots after one fold" do
    assert Day13.part_one(InputTestFile) == 17
  end
end
