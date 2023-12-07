defmodule Day07 do
  defmodule Hand do
    defstruct [:rank, :cards, :bet]

    def build(line) do
      [raw_cards, bet] = String.split(line, " ")

      cards = raw_cards |> String.split("", trim: true) |> Enum.map(&translate/1)
      %__MODULE__{rank: rank(cards), cards: cards, bet: String.to_integer(bet)}
    end

    def rank(cards), do: cards |> Enum.sort() |> rank_sorted()
    defp rank_sorted([a, a, a, a, a]), do: 7
    defp rank_sorted([a, a, a, a, _]), do: 6
    defp rank_sorted([_, a, a, a, a]), do: 6
    defp rank_sorted([a, a, a, b, b]), do: 5
    defp rank_sorted([b, b, a, a, a]), do: 5
    defp rank_sorted([a, a, a, _, _]), do: 4
    defp rank_sorted([_, a, a, a, _]), do: 4
    defp rank_sorted([_, _, a, a, a]), do: 4
    defp rank_sorted([a, a, b, b, _]), do: 3
    defp rank_sorted([a, a, _, b, b]), do: 3
    defp rank_sorted([_, a, a, b, b]), do: 3
    defp rank_sorted([a, a, _, _, _]), do: 2
    defp rank_sorted([_, a, a, _, _]), do: 2
    defp rank_sorted([_, _, a, a, _]), do: 2
    defp rank_sorted([_, _, _, a, a]), do: 2
    defp rank_sorted([_a, _b, _c, _d, _e]), do: 1

    defp translate("A"), do: 14
    defp translate("K"), do: 13
    defp translate("Q"), do: 12
    defp translate("J"), do: 11
    defp translate("T"), do: 10
    defp translate(c), do: String.to_integer(c)

    def cmp(%__MODULE__{rank: r, cards: c1}, %__MODULE__{rank: r, cards: c2}) when c1 < c2, do: -1
    def cmp(%__MODULE__{rank: r, cards: c1}, %__MODULE__{rank: r, cards: c2}) when c1 > c2, do: 1
    def cmp(%__MODULE__{rank: r1}, %__MODULE__{rank: r2}), do: r1 - r2
  end

  defmodule WildHand do
    defstruct [:rank, :cards, :bet]

    def build(line) do
      [raw_cards, bet] = String.split(line, " ")

      cards = raw_cards |> String.split("", trim: true) |> Enum.map(&translate/1)
      %__MODULE__{rank: rank(cards), cards: cards, bet: String.to_integer(bet)}
    end

    def rank(cards), do: cards |> Enum.sort() |> Enum.reverse() |> rank_sorted()
    defp rank_sorted([a, a, a, a, a]), do: 7
    defp rank_sorted([a, a, a, a, 1]), do: 7
    defp rank_sorted([a, a, a, 1, 1]), do: 7
    defp rank_sorted([a, a, 1, 1, 1]), do: 7
    defp rank_sorted([_, 1, 1, 1, 1]), do: 7
    defp rank_sorted([a, a, a, a, _]), do: 6
    defp rank_sorted([_, _, 1, 1, 1]), do: 6
    defp rank_sorted([a, a, _, 1, 1]), do: 6
    defp rank_sorted([a, a, a, _, 1]), do: 6
    defp rank_sorted([_, a, a, a, a]), do: 6
    defp rank_sorted([_, a, a, a, 1]), do: 6
    defp rank_sorted([_, a, a, 1, 1]), do: 6
    defp rank_sorted([a, a, a, b, b]), do: 5
    defp rank_sorted([b, b, a, a, a]), do: 5
    defp rank_sorted([a, a, b, b, 1]), do: 5
    defp rank_sorted([a, a, a, _, _]), do: 4
    defp rank_sorted([a, a, _, _, 1]), do: 4
    defp rank_sorted([_, _, _, 1, 1]), do: 4
    defp rank_sorted([_, a, a, a, _]), do: 4
    defp rank_sorted([_, a, a, _, 1]), do: 4
    defp rank_sorted([_, _, a, a, a]), do: 4
    defp rank_sorted([_, _, a, a, 1]), do: 4
    defp rank_sorted([a, a, b, b, _]), do: 3
    defp rank_sorted([a, a, _, b, b]), do: 3
    defp rank_sorted([_, a, a, b, b]), do: 3
    defp rank_sorted([a, a, _, _, _]), do: 2
    defp rank_sorted([_, _, _, _, 1]), do: 2
    defp rank_sorted([_, a, a, _, _]), do: 2
    defp rank_sorted([_, _, a, a, _]), do: 2
    defp rank_sorted([_, _, _, a, a]), do: 2
    defp rank_sorted([_a, _b, _c, _d, _e]), do: 1

    defp translate("A"), do: 14
    defp translate("K"), do: 13
    defp translate("Q"), do: 12
    defp translate("J"), do: 1
    defp translate("T"), do: 10
    defp translate(c), do: String.to_integer(c)

    def cmp(%__MODULE__{rank: r, cards: c1}, %__MODULE__{rank: r, cards: c2}) when c1 < c2, do: -1
    def cmp(%__MODULE__{rank: r, cards: c1}, %__MODULE__{rank: r, cards: c2}) when c1 > c2, do: 1
    def cmp(%__MODULE__{rank: r1}, %__MODULE__{rank: r2}), do: r1 - r2
  end

  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&Hand.build/1)
    |> Enum.sort(fn h1, h2 -> Hand.cmp(h1, h2) < 0 end)
    |> Enum.map(fn hand -> hand.bet end)
    |> Enum.with_index
    |> Enum.map(fn {bet, idx} -> bet * (idx + 1) end)
    |> Enum.sum
  end

  def part_two(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&WildHand.build/1)
    |> Enum.sort(fn h1, h2 -> WildHand.cmp(h1, h2) < 0 end)
    |> Enum.map(fn hand -> hand.bet end)
    |> Enum.with_index
    |> Enum.map(fn {bet, idx} -> bet * (idx + 1) end)
    |> Enum.sum
  end
end
