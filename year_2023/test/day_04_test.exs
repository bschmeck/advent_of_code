defmodule Day04Test do
  use ExUnit.Case, async: true

  test "it sums the scores" do
    assert Day04.part_one(InputTestFile) == 13
  end

  test "it totals the cards won" do
    assert Day04.part_two(InputTestFile) == 30
  end

  test "it scores a single game" do
    winners = MapSet.new([41, 48, 83, 86, 17])
    given = MapSet.new([83, 86, 6, 31, 17, 9, 48, 53])
    assert Day04.score([winners, given]) == 8
  end
end
