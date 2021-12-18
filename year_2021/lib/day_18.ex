defmodule Day18 do
  def part_one(input) do
    input
    |> sum_input()
    |> magnitude()
  end

  def magnitude(l) when is_binary(l), do: l |> parse() |> magnitude()
  def magnitude(l), do: l |> do_magnitude() |> elem(0)

  defp do_magnitude(["[" | rest]) do
    {left_mag, rest} = do_magnitude(rest)
    {right_mag, rest} = do_magnitude(rest)
    {3 * left_mag + 2 * right_mag, rest}
  end

  defp do_magnitude(["]" | rest]), do: do_magnitude(rest)
  defp do_magnitude([n | rest]), do: {n, rest}

  def sum_input(input) do
    18
    |> input.contents_of(:stream)
    |> Enum.map(&String.trim/1)
    |> sum()
  end

  def sum(list) do
    list
    |> Enum.map(&parse/1)
    |> Enum.reduce(fn a, b -> add(b, a) end)
  end

  def add(a, b) when is_binary(a) and is_binary(b), do: add(parse(a), parse(b))
  def add(a, b), do: (["["] ++ a ++ b ++ ["]"]) |> reduce()

  def reduce(l) when is_binary(l), do: l |> parse() |> reduce()

  def reduce(l) do
    reduced = l |> explode() |> split()

    if l == reduced do
      reduced
    else
      reduce(reduced)
    end
  end

  def explode(l) when is_binary(l), do: l |> parse() |> explode()
  def explode(l), do: do_explode(l, [], 0, 0)

  def split(l), do: do_split(l, [])

  defp do_split([], result), do: Enum.reverse(result)

  defp do_split([n | rest], result) when is_number(n) and n >= 10,
    do: Enum.reverse(result) ++ ["[", div(n, 2), div(n, 2) + rem(n, 2), "]" | rest]

  defp do_split([n | rest], result), do: do_split(rest, [n | result])

  defp do_explode([], exploded, 0, _prev), do: Enum.reverse(exploded)

  defp do_explode(["[" | rest], exploded, depth, p),
    do: do_explode(rest, ["[" | exploded], depth + 1, p)

  defp do_explode(["]" | rest], exploded, depth, p),
    do: do_explode(rest, ["]" | exploded], depth - 1, p)

  defp do_explode([a, b, "]" | rest], ["[" | exploded], 5, p),
    do: do_explode(rest, [0 | backfill(exploded, a + p, [])], 4, b)

  defp do_explode([c | rest], exploded, depth, prev),
    do: do_explode(rest, [c + prev | exploded], depth, 0)

  defp backfill([], _a, backfilled), do: Enum.reverse(backfilled)

  defp backfill([n | rest], a, backfilled) when is_number(n),
    do: Enum.reverse(backfilled) ++ [n + a | rest]

  defp backfill([c | rest], a, backfilled), do: backfill(rest, a, [c | backfilled])

  def parse(l) do
    l
    |> String.split("", trim: true)
    |> Enum.reject(fn c -> c == "," end)
    |> Enum.map(fn
      "[" -> "["
      "]" -> "]"
      c -> String.to_integer(c)
    end)
  end
end
