defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day05.part_one(InputTestFile) == 3
  end

  test "it can solve part two" do
    assert Day05.part_two(InputTestFile) == 14
  end

  test "it can combine ranges" do
    assert Day05.combine([[1, 5], [10, 15]]) |> Enum.sort == Enum.sort([[1, 5], [10, 15]])
    assert Day05.combine([[10, 15], [1, 5]]) |> Enum.sort == Enum.sort([[1, 5], [10, 15]])
    assert Day05.combine([[1, 5], [2, 4]]) |> Enum.sort == Enum.sort([[1, 5]])
    assert Day05.combine([[2, 4], [1, 5]]) |> Enum.sort == Enum.sort([[1, 5]])
    assert Day05.combine([[2, 5], [1, 3]]) |> Enum.sort == Enum.sort([[1, 5]])
    assert Day05.combine([[1, 3], [2, 5]]) |> Enum.sort == Enum.sort([[1, 5]])
    assert Day05.combine([[1, 3], [2, 5], [10, 15]]) |> Enum.sort == Enum.sort([[1, 5], [10, 15]])
    assert Day05.combine([[1, 5], [7, 10], [3, 8]]) |> Enum.sort == Enum.sort([[1, 10]])
  end
end
