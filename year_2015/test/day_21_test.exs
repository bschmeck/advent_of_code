defmodule Day21Test do
  use ExUnit.Case, async: true

  test "it can fight a single turn" do
    player = %Day21.Player{hit_points: 8, damage: 5, armor: 5}
    boss = %Day21.Player{hit_points: 12, damage: 7, armor: 2}

    assert %Day21.Player{hit_points: 9, damage: 7, armor: 2} = Day21.fight_turn(player, boss)
  end

  test "it can fight a battle" do
    player = %Day21.Player{hit_points: 8, damage: 5, armor: 5}
    boss = %Day21.Player{hit_points: 12, damage: 7, armor: 2}

    assert :player = Day21.fight_battle(player, boss)
  end
end
