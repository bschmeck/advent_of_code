defmodule Day03.ForestTest do
  use ExUnit.Case

  test "it detects trees" do
    assert Day03.Forest.tree?("..##.......", 2)
  end

  test "it detects the absence of trees" do
    refute Day03.Forest.tree?("..##.......", 4)
  end

  test "it detects trees at the start of the row" do
    assert Day03.Forest.tree?("#.....", 0)
  end

  test "it detects trees at the end of the row" do
    assert Day03.Forest.tree?("#..#..#", 6)
  end
end
