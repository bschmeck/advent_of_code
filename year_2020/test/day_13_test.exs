defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it computes time to the next shuttle" do
    assert Day13.part_one(InputTestFile) == 295
  end
end
