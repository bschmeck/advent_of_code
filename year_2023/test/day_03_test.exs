defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can sum part numbers" do
    assert Day03.part_one(InputTestFile) == 4361
  end

  test "it can turn a row into part numbers and the locations to check for symbols" do
    totals = %{{3, 0} => 467, {0, 1} => 467, {1, 1} => 467, {2, 1} => 467, {3, 1} => 467, {4, 0} => 114, {8, 0} => 114, {4, 1} => 114, {5, 1} => 114, {6, 1} => 114, {7, 1} => 114, {8, 1} => 114}
    assert totals == Day03.parse({"467..114..", 0}, %{})
  end

  test "it can populate a new Map for a single num at the top row" do
    assert %{{3, 0} => 467, {0, 1} => 467, {1, 1} => 467, {2, 1} => 467, {3, 1} => 467} = Day03.populate(%{}, {467, [2, 1, 0]}, 0)
  end

  test "it updates existing totals" do
    assert %{{3, 0} => 469, {0, 1} => 467, {1, 1} => 467, {2, 1} => 467, {3, 1} => 467} = Day03.populate(%{{3, 0} => 2}, {467, [2, 1, 0]}, 0)
  end
end
