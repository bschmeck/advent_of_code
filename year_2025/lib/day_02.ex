defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2)
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.flat_map(&mirrors/1)
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(2)
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.flat_map(&repeats/1)
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def mirrors([from, to]), do: mirrors(String.to_integer(from), String.to_integer(to))
  def mirrors(from, to), do: mirrors(from, to, [])
  def mirrors(from, to, acc) when from > to, do: acc
  def mirrors(from, to, acc) do
    if mirror?(from), do: mirrors(from + 1, to, [from | acc]), else: mirrors(from + 1, to, acc)
  end

  def mirror?(n) do
    digits = :math.log10(n) |> floor() |> Kernel.+(1)
    half = 10 ** div(digits, 2)
    case rem(digits, 2) do
      0 -> rem(n, half) == div(n, half)
      _ -> false
    end
  end

  def repeats([from, to]), do: repeats(String.to_integer(from), String.to_integer(to))
  def repeats(from, to), do: repeats(from, to, [])
  def repeats(from, to, acc) when from > to, do: acc
  def repeats(from, to, acc) do
    if repeat?(from), do: repeats(from + 1, to, [from | acc]), else: repeats(from + 1, to, acc)
  end

  def repeat?(n) when n < 11, do: false
  def repeat?(n) do
    digits = n |> Integer.to_string() |> String.split("", trim: true)
    repeat?(digits, factors(Enum.count(digits)))
  end
  def repeat?(_digits, []), do: false
  def repeat?(digits, [n | rest]) do
    case digits |> Enum.chunk_every(n) |> Enum.uniq() |> Enum.count() do
      1 -> true
      _ -> repeat?(digits, rest)
    end
  end

  def factors(1), do: [1]
  def factors(2), do: [1]
  def factors(3), do: [1]
  def factors(4), do: [1, 2]
  def factors(5), do: [1]
  def factors(6), do: [1, 2, 3]
  def factors(7), do: [1]
  def factors(8), do: [1, 2, 4]
  def factors(9), do: [1, 3]
  def factors(10), do: [1, 2, 5]
  def factors(11), do: [1]
  def factors(n), do: Enum.filter(1..div(n, 2), &(rem(n, &1) == 0))
end
