defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it computes the total score of a cookie" do
    assert Day15.total_score([44, 56], [[8, -1, -2, 6, 3], [3, 2, 3, -2, -1]]) == 62842880
  end
end
