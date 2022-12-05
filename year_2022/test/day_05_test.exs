defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it returns the top of each stack" do
    assert Day05.part_one(InputTestFile) == "CMZ"
  end

  test "it returns the top of each stack when moving multiple" do
    assert Day05.part_two(InputTestFile) == "MCD"
  end

  test "it builds stacks of crates" do
    assert Day05.stacks(InputTestFile) == %{"1" => ["N", "Z"], "2" => ["D", "C", "M"], "3" => ["P"]}
  end

  test "it parses the series of moves" do
    assert Day05.steps(InputTestFile) == [{1, "2", "1"}, {3, "1", "3"}, {2, "2", "1"}, {1, "1", "2"}]
  end
end
