defmodule Day07Test do
  use ExUnit.Case, async: true

  test "it sums the size of directories under 100_000" do
    assert Day07.part_one(InputTestFile) == 95_437
  end

  test "it finds the size of the directory to delete" do
    assert Day07.part_two(InputTestFile) == 24_933_642
  end
end
