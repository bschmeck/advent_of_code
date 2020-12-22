defmodule Day22.RecursiveGame do
  defstruct p1_cards: [],
            p1_next: [],
            p1_total: 0,
            p2_cards: [],
            p2_next: [],
            p2_total: 0,
            building: 1,
            seen: MapSet.new()

  def build(%__MODULE__{building: 1} = game, "Player 1:"), do: game
  def build(%__MODULE__{building: 1} = game, "Player 2:"), do: %__MODULE__{game | building: 2}
  def build(game, ""), do: game

  def build(%__MODULE__{building: 1} = game, n),
    do: %__MODULE__{
      game
      | p1_cards: [String.to_integer(n) | game.p1_cards],
        p1_total: game.p1_total + 1
    }

  def build(%__MODULE__{building: 2} = game, n),
    do: %__MODULE__{
      game
      | p2_cards: [String.to_integer(n) | game.p2_cards],
        p2_total: game.p2_total + 1
    }

  def prepare(%__MODULE__{} = game),
    do: %__MODULE__{
      game
      | p1_cards: Enum.reverse(game.p1_cards),
        p2_cards: Enum.reverse(game.p2_cards)
    }

  def play(%__MODULE__{p1_cards: [], p1_next: []} = game), do: -score(game.p2_cards, game.p2_next)
  def play(%__MODULE__{p2_cards: [], p2_next: []} = game), do: score(game.p1_cards, game.p1_next)

  def play(%__MODULE__{p1_cards: []} = game),
    do: play(%__MODULE__{game | p1_cards: Enum.reverse(game.p1_next), p1_next: []})

  def play(%__MODULE__{p2_cards: []} = game),
    do: play(%__MODULE__{game | p2_cards: Enum.reverse(game.p2_next), p2_next: []})

  def play(game) do
    key =
      {game.p1_cards ++ Enum.reverse(game.p1_next), game.p2_cards ++ Enum.reverse(game.p2_next)}

    case MapSet.member?(game.seen, key) do
      true ->
        score(game.p1_cards, game.p1_next)

      _ ->
        do_play(%__MODULE__{game | seen: game.seen |> MapSet.put(key)})
    end
  end

  def do_play(
        %__MODULE__{p1_cards: [c1 | rest1], p1_total: p1, p2_cards: [c2 | rest2], p2_total: p2} =
          game
      )
      when c1 < p1 and c2 < p2 do
    subgame = %__MODULE__{
      p1_cards: Enum.take(rest1 ++ Enum.reverse(game.p1_next), c1),
      p1_total: c1,
      p2_cards: Enum.take(rest2 ++ Enum.reverse(game.p2_next), c2),
      p2_total: c2
    }

    case play(subgame) do
      x when x < 0 ->
        play(%__MODULE__{
          game
          | p1_cards: rest1,
            p2_cards: rest2,
            p2_next: [c1 | [c2 | game.p2_next]],
            p1_total: game.p1_total - 1,
            p2_total: game.p2_total + 1
        })

      _ ->
        play(%__MODULE__{
          game
          | p1_cards: rest1,
            p2_cards: rest2,
            p1_next: [c2 | [c1 | game.p1_next]],
            p1_total: game.p1_total + 1,
            p2_total: game.p2_total - 1
        })
    end
  end

  def do_play(%__MODULE__{p1_cards: [c1 | rest1], p2_cards: [c2 | rest2]} = game) when c1 > c2 do
    play(%__MODULE__{
      game
      | p1_cards: rest1,
        p2_cards: rest2,
        p1_next: [c2 | [c1 | game.p1_next]],
        p1_total: game.p1_total + 1,
        p2_total: game.p2_total - 1
    })
  end

  def do_play(%__MODULE__{p1_cards: [c1 | rest1], p2_cards: [c2 | rest2]} = game) when c2 > c1 do
    play(%__MODULE__{
      game
      | p1_cards: rest1,
        p2_cards: rest2,
        p2_next: [c1 | [c2 | game.p2_next]],
        p1_total: game.p1_total - 1,
        p2_total: game.p2_total + 1
    })
  end

  def score(a, b) do
    (b ++ Enum.reverse(a))
    |> Enum.with_index(1)
    |> Enum.map(fn {n, i} -> n * i end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
