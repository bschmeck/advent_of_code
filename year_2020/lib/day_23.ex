defmodule Day23 do
  def part_one(cups \\ "463528179", moves \\ 100) do
    cups
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> play(moves)
    |> canonicalize()
  end

  def play(cups, 0), do: cups

  def play([current | [cup1 | [cup2 | [cup3 | rest]]]], n) do
    dest = find_destination(current - 1, cup1, cup2, cup3)

    build_cups(rest, [cup1, cup2, cup3], dest, current, [])
    |> play(n - 1)
  end

  def find_destination(0, cup1, cup2, cup3), do: find_destination(9, cup1, cup2, cup3)

  def find_destination(guess, cup1, cup2, cup3)
      when guess == cup1 or guess == cup2 or guess == cup3 do
    find_destination(guess - 1, cup1, cup2, cup3)
  end

  def find_destination(guess, _cup1, _cup2, _cup3), do: guess

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
end
