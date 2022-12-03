defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it sums the priorities of duplicate items" do
    assert Day03.part_one(InputTestFile) == 157
  end

  test "it finds the priorities of badges" do
    assert Day03.part_two(InputTestFile) == 70
  end
end
