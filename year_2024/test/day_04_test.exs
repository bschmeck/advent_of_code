defmodule Day04Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day04.part_one(InputTestFile) == 18
  end

  test "it can solve part two" do
    assert Day04.part_two(InputTestFile) == 9
  end
end
