defmodule Day03 do
  def part_one(input \\ InputFile) do
    input.contents_of(3, :stream)
    |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&(joltage(&1, 2)))
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(3, :stream)
    |> Enum.map(fn line -> line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&(joltage(&1, 12)))
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def joltage(list, n) do
    zeros = for _ <- list, do: 0

    joltage(zeros, n, 1, Enum.reverse(list))
  end

  def joltage(best, n, m, _list) when m > n, do: Enum.max(best)
  def joltage(best, n, m, list) do
    best
    |> Enum.zip(list)
    |> Enum.map(fn {x, y} -> y * 10**(m-1) + x end)
    |> Enum.reduce([], fn
      elt, [] -> [elt]
      elt, [prev | _] = best when elt > prev -> [elt | best]
      _elt, [prev | _] = best -> [prev | best]
    end)
    |> Enum.reverse()
    |> joltage(n, m + 1, tl(list))
  end
end
