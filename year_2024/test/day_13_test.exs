defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day13.part_one(InputTestFile) == 480
  end
end
