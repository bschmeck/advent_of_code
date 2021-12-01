defmodule Day01 do
  def part_one(module) do
    module.contents_of(1, :stream)
    |> Stream.map(&String.trim_trailing(&1))
    |> Stream.map(fn l -> l |> Integer.parse() |> elem(0) end)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.filter(fn [a, b] -> a < b end)
    |> Enum.count()
  end

  def part_two(module) do
    module.contents_of(1, :stream)
    |> Stream.map(&String.trim_trailing(&1))
    |> Stream.map(fn l -> l |> Integer.parse() |> elem(0) end)
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.map(&Enum.sum(&1))
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.filter(fn [a, b] -> a < b end)
    |> Enum.count()
  end
end
