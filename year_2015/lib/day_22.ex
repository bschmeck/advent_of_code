defmodule Day22 do
  def part_one() do
    boss = %{hit_points: 55, damage: 8}
    wizard = %{hit_points: 50, mana: 500}

    magic_missle = %Day22.Spell{cost: 53, turns: nil, effect: fn wizard, boss -> [wizard, Map.update!(boss, :hit_points, &(&1 - 4))]}
    drain = %Day22.Spell{cost: 73, turns: nil, effect: fn wizard, boss -> [Map.update!(wizard, :hit_points, &(&1 + 2)), Map.update!(boss, :hit_points, &(&1 - 2))]}
    shield = %Day22.Spell{cost: 113, turns: 6, effect: fn wizard, boss -> [wizard, boss] end}
    poison = %Day22.Spell{cost: 173, turns: 6, effect: fn wizard, boss -> [wizard, Map.update!(boss, :hit_points, &(&1 - 3))] end}
    rechard = %Day22.Spell{cost: 229, turns: 5, effect: fn wizard, boss -> [Map.update!(wizard, :mana, &(&1 + 101)), boss] end}

  end
end
