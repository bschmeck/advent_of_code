defmodule Day21.PlayerTest do
  use ExUnit.Case, async: true

  test "it can compute damage dealt" do
    player = %Day21.Player{hit_points: 8, damage: 5, armor: 5}
    boss = %Day21.Player{hit_points: 12, damage: 7, armor: 2}

    assert Day21.Player.damage_inflicted(player, boss) == 3
    assert Day21.Player.damage_inflicted(boss, player) == 2
  end

  test "there is a minium damage dealt" do
    assert Day21.Player.damage_inflicted(%Day21.Player{damage: 0}, %Day21.Player{armor: 300}) == 1
  end

  test "it can take damage" do
    boss = %Day21.Player{hit_points: 12, damage: 7, armor: 2}

    assert %Day21.Player{hit_points: 9} = Day21.Player.take_damage(boss, 3)
  end

  test "it takes at most hit_points worth of damage" do
    boss = %Day21.Player{hit_points: 12, damage: 7, armor: 2}

    assert %Day21.Player{hit_points: 0} = Day21.Player.take_damage(boss, 100)
  end
end
