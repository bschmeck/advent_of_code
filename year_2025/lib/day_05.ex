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

  def part_two(_input \\ InputFile) do

  end

  def fresh?([], _ingredient), do: false
  def fresh?([[min, max] | _rest], ingredient) when min <= ingredient and max >= ingredient, do: true
  def fresh?([_range | rest], ingredient), do: fresh?(rest, ingredient)
end
