defmodule Day10 do
  def part_one(sequence \\ "1321131112"), do: sequence |> play(40) |> String.length
  def part_two(sequence \\ "1321131112"), do: sequence |> play(50) |> String.length

  def play(sequence, 0), do: sequence
  def play(sequence, n) do
    sequence
    |> String.split("", trim: true)
    |> Enum.chunk_while([], &chunk_fun/2, &after_fun/1)
    |> Enum.map(fn chunk -> [Enum.count(chunk), hd(chunk)] end)
    |> Enum.concat()
    |> Enum.join()
    |> play(n - 1)
  end

  def chunk_fun(elt, []), do: {:cont, [elt]}
  def chunk_fun(elt, acc) when hd(acc) == elt, do: {:cont, [elt | acc]}
  def chunk_fun(elt, acc), do: {:cont, acc, [elt]}

  def after_fun(acc), do: {:cont, acc, acc}
end
