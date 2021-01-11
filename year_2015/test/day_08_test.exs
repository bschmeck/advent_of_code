defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it gets the answer for part one" do
    assert Day08.part_one(InputTestFile) == 12
  end

  test "it gets the answer for part two" do
    assert Day08.part_two(InputTestFile) == 19
  end
end
