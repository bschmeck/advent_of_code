defmodule Day22.Game do
  defstruct p1_cards: [], p1_next: [], p2_cards: [], p2_next: [], building: 1

  def build(%__MODULE__{building: 1} = game, "Player 1:"), do: game
  def build(%__MODULE__{building: 1} = game, "Player 2:"), do: %__MODULE__{game | building: 2}
  def build(game, ""), do: game

  def build(%__MODULE__{building: 1} = game, n),
    do: %__MODULE__{game | p1_cards: [String.to_integer(n) | game.p1_cards]}

  def build(%__MODULE__{building: 2} = game, n),
    do: %__MODULE__{game | p2_cards: [String.to_integer(n) | game.p2_cards]}

  def prepare(%__MODULE__{} = game),
    do: %__MODULE__{
      game
      | p1_cards: Enum.reverse(game.p1_cards),
        p2_cards: Enum.reverse(game.p2_cards)
    }

  def play(%__MODULE__{p1_cards: [], p1_next: []} = game), do: score(game.p2_cards, game.p2_next)
  def play(%__MODULE__{p2_cards: [], p2_next: []} = game), do: score(game.p1_cards, game.p1_next)

  def play(%__MODULE__{p1_cards: []} = game),
    do: play(%__MODULE__{game | p1_cards: Enum.reverse(game.p1_next), p1_next: []})

  def play(%__MODULE__{p2_cards: []} = game),
    do: play(%__MODULE__{game | p2_cards: Enum.reverse(game.p2_next), p2_next: []})

  def play(%__MODULE__{p1_cards: [c1 | rest1], p2_cards: [c2 | rest2]} = game) when c1 > c2 do
    play(%__MODULE__{game | p1_cards: rest1, p2_cards: rest2, p1_next: [c2 | [c1 | game.p1_next]]})
  end

  def play(%__MODULE__{p1_cards: [c1 | rest1], p2_cards: [c2 | rest2]} = game) when c2 > c1 do
    play(%__MODULE__{game | p1_cards: rest1, p2_cards: rest2, p2_next: [c1 | [c2 | game.p2_next]]})
  end

  def score(a, b) do
    (b ++ Enum.reverse(a))
    |> Enum.with_index(1)
    |> Enum.map(fn {n, i} -> n * i end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
