defmodule Day07Test do
  use ExUnit.Case, async: true

  test "it computes the fuel needed to align crabs" do
    assert Day07.part_one(InputTestFile) == 37
  end

  test "it computes the fuel needed to align crabs using a more complicated cost" do
    assert Day07.part_two(InputTestFile) == 168
  end
end
