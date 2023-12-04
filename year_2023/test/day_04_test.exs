defmodule Day04Test do
  use ExUnit.Case, async: true

  test "it sums the scores" do
    assert Day04.part_one(InputTestFile) == 13
  end

  test "it scores a single game" do
    score = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
    |> Day04.parse
    |> Day04.score

    assert score == 8
  end
end
