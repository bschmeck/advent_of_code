defmodule Day23 do
  def part_one(cups \\ "463528179", moves \\ 100) do
    cups
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> play(moves)
    |> canonicalize()
  end

  def part_two(cups \\ "463528179") do
    cups
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.concat(10..1_000_000)
    |> play(10_000_000, 1_000_000)
    |> find_cups(nil, nil)
  end

  def play(cups, moves, max \\ 9)
  def play(cups, 0, _max), do: cups

  def play([current | [cup1 | [cup2 | [cup3 | rest]]]], n, max) do
    dest = find_destination(current - 1, cup1, cup2, cup3, max)

    build_cups(rest, [cup1, cup2, cup3], dest, current, [])
    |> play(n - 1, max)
  end

  def find_destination(0, cup1, cup2, cup3, max), do: find_destination(max, cup1, cup2, cup3, max)

  def find_destination(guess, cup1, cup2, cup3, max)
      when guess == cup1 or guess == cup2 or guess == cup3 do
    find_destination(guess - 1, cup1, cup2, cup3, max)
  end

  def find_destination(guess, _cup1, _cup2, _cup3, _max), do: guess

  def canonicalize(cups) do
    {a, b} = cups |> Enum.split_while(&(&1 != 1))

    "#{Enum.join(tl(b))}#{Enum.join(a)}"
  end

  def build_cups([], _removed, _dest, prev_current, cups) do
    Enum.reverse([prev_current | cups])
  end

  def build_cups([dest | rest], [c1, c2, c3], dest, prev_current, cups) do
    build_cups(rest, :done, dest, prev_current, [c3 | [c2 | [c1 | [dest | cups]]]])
  end

  def build_cups([cup | rest], removed, dest, prev_current, cups) do
    build_cups(rest, removed, dest, prev_current, [cup | cups])
  end

  def find_cups([1 | [cup1 | [cup2 | _rest]]], _first, _second), do: cup1 * cup2
  def find_cups([1 | [cup1 | []]], first, _second), do: cup1 * first
  def find_cups([1], first, second), do: first * second
  def find_cups([cup | rest], nil, nil), do: find_cups(rest, cup, nil)
  def find_cups([cup | rest], first, nil), do: find_cups(rest, first, cup)
  def find_cups([_cup | rest], first, second), do: find_cups(rest, first, second)
end
