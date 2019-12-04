defmodule Day04.Password do
  def possible?(p) do
    [n | rest] = p |> Integer.to_charlist

    has_adjacent_same_digits?(rest, n) &&
    never_decreases?(rest, n)
  end

  def has_adjacent_same_digits?([], _), do: false
  def has_adjacent_same_digits?([n | _rest], n), do: true
  def has_adjacent_same_digits?([n | rest], _), do: has_adjacent_same_digits?(rest, n)

  def never_decreases?([], _), do: true
  def never_decreases?([a | _rest], b) when a < b, do: false
  def never_decreases?([a | rest], _), do: never_decreases?(rest, a)
end

IO.inspect Day04.Password.possible?(111111)
IO.inspect Day04.Password.possible?(223450)
IO.inspect Day04.Password.possible?(123456)

(for x <- 271973..785961, do: x)
|> Enum.count(&Day04.Password.possible?/1)
|> IO.inspect
