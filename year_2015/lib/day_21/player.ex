defmodule Day21.Player do
  defstruct [:hit_points, :damage, :armor]

  def damage_inflicted(%__MODULE__{damage: damage} = _aggressor, %__MODULE__{armor: armor} = _victim) do
    Enum.max([1, damage - armor])
  end

  def take_damage(%__MODULE__{hit_points: hp} = victim, inflicted) when inflicted > hp, do: take_damage(victim, hp)
  def take_damage(%__MODULE__{hit_points: hp} = victim, inflicted), do: %__MODULE__{victim | hit_points: hp - inflicted}

  def add_item(%__MODULE__{damage: damage, armor: armor} = player, %Day21.Item{} = item) do
    %__MODULE__{player | damage: damage + item.damage, armor: armor + item.armor}
  end
end
