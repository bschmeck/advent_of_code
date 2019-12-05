defmodule Day04.Password do
  def possible?(p) do
    l = p |> Integer.to_charlist

    has_adjacent_same_digits?(l) &&
    never_decreases?(l)
  end

  def has_adjacent_same_digits?([_ | []]), do: false
  def has_adjacent_same_digits?([n | [n | _rest]]), do: true
  def has_adjacent_same_digits?([_n | [x | rest]]), do: has_adjacent_same_digits?([x | rest])

  def never_decreases?([_ | []]), do: true
  def never_decreases?([a | [b | _rest]]) when a > b, do: false
  def never_decreases?([_a | [b | rest]]), do: never_decreases?([b | rest])
end

IO.inspect Day04.Password.possible?(111111)
IO.inspect Day04.Password.possible?(223450)
IO.inspect Day04.Password.possible?(123456)

(for x <- 271973..785961, do: x)
|> Enum.count(&Day04.Password.possible?/1)
|> IO.inspect
