defmodule Day09 do
  def part_one(input \\ InputFile) do
    input.contents_of(9, :stream)
    |> Enum.map(&next_in/1)
    |> Enum.sum
  end

  def part_two(input \\ InputFile) do
    input.contents_of(9, :stream)
    |> Enum.map(&prev_in/1)
    |> Enum.sum
  end

  def next_in(raw_series) do
    raw_series
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> reduce([])
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&Kernel.hd/1)
    |> Enum.sum()
  end

  def prev_in(raw_series) do
    raw_series
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> reduce([])
    |> Enum.map(&Kernel.hd/1)
    |> Enum.reduce(fn elt, prev_val -> elt - prev_val end)
  end

  def reduce(series, reductions) do
    if Enum.all?(series, &(&1 == 0)), do: reductions, else: series |> deltas() |> reduce([series | reductions])
  end

  def deltas(series) do
    series
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end
end
