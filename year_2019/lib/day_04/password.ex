defmodule Day04.Password do
  def possible_part1?(p) do
    l = p |> Integer.to_charlist

    has_adjacent_same_digits?(l) &&
    never_decreases?(l)
  end

  def possible?(p) do
    l = p |> Integer.to_charlist

    has_adjacent_same_digits_twice?(l) &&
    never_decreases?(l)
  end

  def has_adjacent_same_digits_twice?([a, a, b, _, _, _]) when a != b, do: true
  def has_adjacent_same_digits_twice?([a, b, b, c, _, _]) when a != b and b != c, do: true
  def has_adjacent_same_digits_twice?([_, a, b, b, c, _]) when a != b and b != c, do: true
  def has_adjacent_same_digits_twice?([_, _, a, b, b, c]) when a != b and b != c, do: true
  def has_adjacent_same_digits_twice?([_, _, _, a, b, b]) when a != b, do: true
  def has_adjacent_same_digits_twice?(_), do: false

  def has_adjacent_same_digits?([a, a, _, _, _, _]), do: true
  def has_adjacent_same_digits?([_, a, a, _, _, _]), do: true
  def has_adjacent_same_digits?([_, _, a, a, _, _]), do: true
  def has_adjacent_same_digits?([_, _, _, a, a, _]), do: true
  def has_adjacent_same_digits?([_, _, _, _, a, a]), do: true
  def has_adjacent_same_digits?(_), do: false

  def never_decreases?([a, b, c, d, e, f]) when a > b or b > c or c > d or d > e or e > f, do: false
  def never_decreases?(_), do: true

  def run(:part1), do: count_with(&Day04.Password.possible_part1?/1)
  def run(:part2), do: count_with(&Day04.Password.possible?/1)

  def count_with(f) do
    (for x <- 271973..785961, do: x)
    |> Enum.count(f)
    |> IO.puts
  end
end
