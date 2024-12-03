defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day03.part_one(InputTestFile) == 161
  end

  @tag :skip
  test "it can solve part two" do
    assert Day03.part_two(InputTestFile) == nil
  end
end
