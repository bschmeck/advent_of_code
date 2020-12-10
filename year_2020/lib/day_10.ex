defmodule Day10 do
  def part_one(file_reader \\ InputFile) do
    deltas = file_reader.contents_of(10, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort
    |> List.insert_at(0, 0)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)

    # Add an extra delta of 3 bc our device has 3 jolts more than the last adapter
    Enum.count(deltas, &(&1 == 1)) * (Enum.count(deltas, &(&1 == 3)) + 1)
  end
end
