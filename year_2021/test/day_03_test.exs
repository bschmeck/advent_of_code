defmodule Day03Test do
  use ExUnit.Case, async: true

  test "it can compute gamma and epsilon" do
    assert Day03.part_one(InputTestFile) == {22, 9}
  end

  test "it can translate an array into a number" do
    assert Day03.decode([1, 1]) == 3
    assert Day03.decode([1, -1, -1]) == 4
    assert Day03.decode([5, -2, 1, 7, -1]) == 22
  end
end
