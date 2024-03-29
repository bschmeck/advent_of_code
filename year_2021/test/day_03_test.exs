defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can compute gamma and epsilon" do
    assert Day03.part_one(InputTestFile) == {22, 9}
  end

  test "it can compute gamma and epsilon with Nx" do
    assert Day03.part_one_nx(InputTestFile) == {22, 9}
  end

  test "it can translate an array into a number" do
    assert Day03.decode([1, 1]) == 3
    assert Day03.decode([1, -1, -1]) == 4
    assert Day03.decode([5, -2, 1, 7, -1]) == 22
  end

  test "it can compute the oxygen rating" do
    assert {23, _} = Day03.part_two(InputTestFile)
  end

  test "it can compute the CO2 rating" do
    assert {_, 10} = Day03.part_two(InputTestFile)
  end
end
