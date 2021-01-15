defmodule Day19Test do
  use ExUnit.Case, async: true

  test "it counts distinct molecules" do
    assert Day19.part_one(InputTestFile) == 4
  end

  test "it counts the steps needed to form the target molecule" do
    assert Day19.part_two(InputTestFile) == 3
  end
end
