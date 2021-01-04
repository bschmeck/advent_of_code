defmodule Day23 do
  def part_one(cups \\ "463528179", moves \\ 100) do
    cups
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> build()
    |> play(String.to_integer(String.at(cups, 0)), 9, moves)
    |> canonicalize()
  end

  def part_two(cups \\ "463528179") do
    result =
      cups
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.concat(10..1_000_000)
      |> build()
      |> play(String.to_integer(String.at(cups, 0)), 1_000_000, 10_000_000)

    cup1 = Map.get(result, 1)
    cup2 = Map.get(result, cup1)

    cup1 * cup2
  end

  def build(cups), do: build(cups, hd(cups), %{})
  def build([final], first, map), do: Map.put(map, final, first)

  def build([cup | [next_cup | rest]], first, map),
    do: build([next_cup | rest], first, Map.put(map, cup, next_cup))

  def play(cups, _current, _max, 0), do: cups

  def play(cups, current, max, moves) do
    rem1 = Map.get(cups, current)
    rem2 = Map.get(cups, rem1)
    rem3 = Map.get(cups, rem2)
    after_rem = Map.get(cups, rem3)
    dest = find_destination(current - 1, rem1, rem2, rem3, max)
    after_dest = Map.get(cups, dest)

    cups
    |> Map.put(current, after_rem)
    |> Map.put(dest, rem1)
    |> Map.put(rem3, after_dest)
    |> play(after_rem, max, moves - 1)
  end

  def find_destination(0, cup1, cup2, cup3, max), do: find_destination(max, cup1, cup2, cup3, max)

  def find_destination(guess, cup1, cup2, cup3, max)
      when guess == cup1 or guess == cup2 or guess == cup3 do
    find_destination(guess - 1, cup1, cup2, cup3, max)
  end

  def find_destination(guess, _cup1, _cup2, _cup3, _max), do: guess

  def canonicalize(cups), do: canonicalize(cups, [Map.get(cups, 1)])
  def canonicalize(_cups, [1 | rest]), do: rest |> Enum.reverse() |> Enum.join()

  def canonicalize(cups, [next | _rest] = canon),
    do: canonicalize(cups, [Map.get(cups, next) | canon])
end
