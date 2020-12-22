defmodule Day22.RecursiveGameTest do
  use ExUnit.Case

  test "it avoids infinite games" do
    game = %Day22.RecursiveGame{p1_cards: [43, 19], p2_cards: [2, 29, 14]}
    assert Day22.RecursiveGame.play(game) > 0
  end
end
