defmodule Day20Test do
  use ExUnit.Case, async: true

  test "it counts lit pixels" do
    assert Day20.part_one(InputTestFile) == 35
  end
end
