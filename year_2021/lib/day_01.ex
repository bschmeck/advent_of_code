defmodule Day01 do
  def part_one(module) do
    module
    |> measurements()
    |> count_increasing()
  end

  def part_two(module) do
    module
    |> measurements()
    |> sliding_window(3)
    |> count_increasing()
  end

  defp measurements(module) do
    module.contents_of(1, :stream)
    |> Stream.map(&String.trim_trailing(&1))
    |> Stream.map(fn l -> l |> Integer.parse() |> elem(0) end)
  end

  defp count_increasing(stream) do
    stream
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.filter(fn [a, b] -> a < b end)
    |> Enum.count()
  end

  defp sliding_window(stream, size) do
    stream
    |> Stream.chunk_every(size, 1, :discard)
    |> Stream.map(&Enum.sum(&1))
  end
end
