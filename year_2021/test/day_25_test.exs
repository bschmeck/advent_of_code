defmodule Day25Test do
  use ExUnit.Case, async: true

  test "it counts the steps until cucumbers stop moving" do
    assert Day25.part_one(InputTestFile) == 58
  end
end
