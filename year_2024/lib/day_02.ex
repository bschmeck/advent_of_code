defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.count(&valid?/1)
  end

  def part_two(_input \\ InputFile) do

  end

  def valid?(arr) do
    deltas = Enum.chunk_every(arr, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)

    Enum.all?(deltas, fn x -> x > 0 && x < 4 end) || Enum.all?(deltas, fn x -> x < 0 && x > -4 end)
  end
end
