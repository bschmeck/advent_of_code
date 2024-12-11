defmodule Day11 do
  def part_one(input \\ InputFile) do
    input.contents_of(11)
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> blink(25)
    |> Enum.count()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(11)
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&({&1, 1}))
    |> blink2(75)
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def blink(stones, 0), do: stones
  def blink(stones, n) do
    stones
    |> Enum.flat_map(&transform/1)
    |> blink(n - 1)
  end

  def blink2(stones, 0), do: stones
  def blink2(stones, n) do
    stones
    |> Enum.flat_map(fn {stone, count} -> stone |> transform() |> Enum.map(&({&1, count})) end)
    |> Enum.reduce(%{}, fn {stone, count}, map -> Map.update(map, stone, count, &(&1 + count)) end)
    |> blink2(n - 1)
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
