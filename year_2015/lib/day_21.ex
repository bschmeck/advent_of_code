defmodule Day21 do
  def part_one() do
    boss = %Day21.Player{hit_points: 103, damage: 9, armor: 2}

    outfits()
    |> Enum.sort_by(&cost_of/1)
    |> Enum.find(fn outfit ->
      player = Enum.reduce(outfit, %Day21.Player{hit_points: 100, damage: 0, armor: 0}, fn item, player -> Day21.Player.add_item(player, item) end)

      fight_battle(player, boss) == :player
    end)
    |> cost_of()
  end

  def part_two() do
    boss = %Day21.Player{hit_points: 103, damage: 9, armor: 2}

    outfits()
    |> Enum.sort_by(&cost_of/1)
    |> Enum.reverse()
    |> Enum.find(fn outfit ->
      player = Enum.reduce(outfit, %Day21.Player{hit_points: 100, damage: 0, armor: 0}, fn item, player -> Day21.Player.add_item(player, item) end)

      fight_battle(player, boss) == :boss
    end)
    |> cost_of()
  end

  def fight_turn(aggressor, victim) do
    inflicted = Day21.Player.damage_inflicted(aggressor, victim)
    Day21.Player.take_damage(victim, inflicted)
  end

  def fight_battle(player, boss), do: fight_battle(player, boss, :player)
  def fight_battle(aggressor, victim, name) do
    case fight_turn(aggressor, victim) do
      %Day21.Player{hit_points: 0} -> name
      victim -> fight_battle(victim, aggressor, toggle(name))
    end
  end

  def toggle(:player), do: :boss
  def toggle(:boss), do: :player

  def outfits() do
    # 1 weapon, 0 armor, 0 rings
    # 1 weapon, 0 armor, 1 ring
    # 1 weapon, 0 armor, 2 rings
    # 1 weapon, 1 armor, 0 rings
    # 1 weapon, 1 armor, 1 ring
    # 1 weapon, 1 armor, 2 rings
    for weapon <- weapons(), armor <- armors(), [ring_a, ring_b] <- ring_choices(), do: [weapon, armor, ring_a, ring_b]
  end

  def weapons() do
    [
      [8,4,0],
      [10,5,0],
      [25,6,0],
      [40,7,0],
      [74,8,0]
    ]
    |> Enum.map(fn [cost, damage, armor] -> %Day21.Item{cost: cost, damage: damage, armor: armor} end)
  end

  def armors() do
    [
      [0,0,0],
      [13,0,1],
      [31,0,2],
      [53,0,3],
      [75,0,4],
      [102,0,5]
    ]
    |> Enum.map(fn [cost, damage, armor] -> %Day21.Item{cost: cost, damage: damage, armor: armor} end)
  end

  def ring_choices() do
    rings = [
      [0,0,0],
      [25,1,0],
      [50,2,0],
      [100,3,0],
      [20,0,1],
      [40,0,2],
      [80,0,3]
    ]
    |> Enum.map(fn [cost, damage, armor] -> %Day21.Item{cost: cost, damage: damage, armor: armor} end)

    [[hd(rings), hd(rings)] | combos(rings)]
  end

  def cost_of(outfit) do
    outfit
    |> Enum.map(&(&1.cost))
    |> Enum.reduce(&Kernel.+/2)
  end

  def combos([item | rest]), do: combos(item, rest, [], [])
  def combos(_item, [], ret, []), do: ret
  def combos(_prev, [], ret, [item | rest]), do: combos(item, rest, ret, [])
  def combos(item, [other | rest], ret, keep), do: combos(item, rest, [[item, other] | ret], [other | keep])
end
