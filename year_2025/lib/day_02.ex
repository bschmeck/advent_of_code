defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2)
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.flat_map(&mirrors/1)
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

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
end
