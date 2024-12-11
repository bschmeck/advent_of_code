defmodule Day11 do
  def part_one(input \\ InputFile) do
    input.contents_of(11)
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> blink(25)
    |> Enum.count()
  end

  def part_two(_input \\ InputFile) do

  end

  def blink(stones, 0), do: stones
  def blink(stones, n) do
    stones
    |> Enum.flat_map(&transform/1)
    |> blink(n - 1)
  end

  def transform(0), do: [1]
  def transform(stone) do
    digits = count_digits(stone)
    case rem(digits, 2) do
      0 -> [div(stone, 10 ** div(digits, 2)), rem(stone, 10 ** div(digits, 2))]
      _ -> [stone * 2024]
    end
  end

  def count_digits(n), do: count_digits(n, 0)
  def count_digits(n, count) when n < 10, do: count + 1
  def count_digits(n, count), do: count_digits(div(n, 10), count + 1)
end
