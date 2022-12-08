defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day08.part_one(InputTestFile) == 21
  end

  test "it can solve part two" do
    assert Day08.part_two(InputTestFile) == 8
  end
end
