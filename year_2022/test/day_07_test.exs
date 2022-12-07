defmodule Day07Test do
  use ExUnit.Case, async: true

  test "it sums the size of directories under 100_000" do
    assert Day07.part_one(InputTestFile) == 95_437
  end

  @tag :skip
  test "it can solve part two" do

  end
end
