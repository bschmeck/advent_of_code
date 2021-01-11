defmodule Day11 do
  def part_one(password \\ "hepxcrrq"), do: next_password(password)
  def part_two(password \\ "hepxcrrq"), do: password |> next_password() |> next_password()

  def next_password(password) do
    password
    |> String.to_charlist
    |> Enum.reverse
    |> advance()
    |> Stream.iterate(&advance/1)
    |> Enum.find(&valid_password?/1)
    |> Enum.reverse
    |> Kernel.to_string()
  end

  def advance([?z | rest]), do: [?a | advance(rest)]
  def advance([?h | rest]), do: [?j | rest]
  def advance([?n | rest]), do: [?p | rest]
  def advance([?k | rest]), do: [?m | rest]
  def advance([c | rest]), do: [c + 1 | rest]

  def valid_password?(l), do: increasing_straight?(l) && two_pairs?(l)

  def increasing_straight?([]), do: false
  def increasing_straight?([a | [b | [c | _rest]]]) when a == b + 1 and b == c + 1, do: true
  def increasing_straight?([_char | rest]), do: increasing_straight?(rest)

  def two_pairs?(l) do
    l
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.with_index()
    |> Enum.filter(fn {[a, b], _i} -> a == b end)
    |> Enum.map(fn {_pair, indx} -> indx end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [a, b] -> b - a > 1 end)
  end
end
