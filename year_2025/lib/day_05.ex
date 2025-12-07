defmodule Day05 do
  def part_one(input \\ InputFile) do
    [fresh, avail] = input.contents_of(5) |> String.split("\n\n")

    ranges = fresh
    |> String.split("\n", trim: true)
    |> Enum.map(fn r -> String.split(r, "-") |> Enum.map(&String.to_integer/1) end)

    avail
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.count(&(fresh?(ranges, &1)))
  end

  def part_two(input \\ InputFile) do
    [fresh, _avail] = input.contents_of(5) |> String.split("\n\n")

    fresh
    |> String.split("\n", trim: true)
    |> Enum.map(fn r -> String.split(r, "-") |> Enum.map(&String.to_integer/1) end)
    |> combine()
    |> Enum.map(&size/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def combine([range | rest]), do: combine(rest, [range], [])
  def combine([], acc, []), do: acc
  def combine([range | rest], [], tmp), do: combine(rest, [range | tmp], [])
  def combine([[_min_a, max_a] | _rest] = ranges, [[min_b, max_b] | acc], tmp) when max_a < min_b, do: combine(ranges, acc, [[min_b, max_b] | tmp])
  def combine([[min_a, _max_a] | _rest] = ranges, [[min_b, max_b] | acc], tmp) when min_a > max_b, do: combine(ranges, acc, [[min_b, max_b] | tmp])
  def combine([[min_a, max_a] | rest], [[min_b, max_b] | acc], tmp) when min_a >= min_b and max_a <= max_b, do: combine(rest, [[min_b, max_b] | acc] ++ tmp, [])
  def combine([[min_a, max_a] | _rest] = ranges, [[min_b, max_b] | acc], tmp) when min_a <= min_b and max_a >= max_b, do: combine(ranges, acc ++ tmp, [])
  def combine([[min_a, max_a] | rest], [[min_b, max_b] | acc], tmp) when min_a < min_b and max_a <= max_b, do: combine([[min_a, max_b] | rest], tmp ++ acc, [])
  def combine([[min_a, max_a] | rest], [[min_b, max_b] | acc], tmp) when min_a >= min_b and max_a > max_b, do: combine([[min_b, max_a] | rest], tmp ++ acc, [])

  def size([min, max]), do: max - min + 1

  def fresh?([], _ingredient), do: false
  def fresh?([[min, max] | _rest], ingredient) when min <= ingredient and max >= ingredient, do: true
  def fresh?([_range | rest], ingredient), do: fresh?(rest, ingredient)
end
