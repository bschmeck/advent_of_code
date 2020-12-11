defmodule Day10 do
  def part_one(file_reader \\ InputFile) do
    deltas =
      jolts(file_reader)
      |> Enum.sort()
      |> List.insert_at(0, 0)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> b - a end)

    # Add an extra delta of 3 bc our device has 3 jolts more than the last adapter
    Enum.count(deltas, &(&1 == 1)) * (Enum.count(deltas, &(&1 == 3)) + 1)
  end

  # A 3 jolt delta means that we have to include the pair of adapters with that delta.
  # So we can split into chunks of non-3 deltas, figure out the allowed combos of those
  # non-3 jolt delta adapters, and then multiply those combos to get the final number
  # of allowed combinations.
  def part_two(file_reader \\ InputFile) do
    jolts(file_reader)
    |> Enum.sort()
    |> List.insert_at(0, 0)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
    |> Enum.chunk_while([], &chunk/2, &finish/1)
    |> Enum.reject(&(&1 == nil))
    |> Enum.map(&Enum.reverse(&1))
    |> Enum.map(&combos/1)
    |> Enum.reduce(fn a, b -> a * b end)
  end

  def jolts(file_reader) do
    file_reader.contents_of(10, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def valid_orderings(joltages), do: valid_orderings([[0]], joltages)

  def valid_orderings(orderings, [joltage]),
    do: Enum.filter(orderings, fn o -> joltage - hd(o) <= 3 end)

  def valid_orderings(orderings, [joltage | rest]) do
    orderings
    |> Enum.flat_map(fn
      o when joltage - hd(o) <= 3 -> [o, [joltage | o]]
      _ -> []
    end)
    |> valid_orderings(rest)
  end

  def chunk(3, acc), do: {:cont, [3 | acc], []}
  def chunk(v, acc), do: {:cont, [v | acc]}
  def finish(acc), do: {:cont, [3 | acc], []}

  # Just a 3-delta in isolation means the adapter has to be included
  def combos([3]), do: 1
  # A 1-3 combo means both are needed (otherwise the delta would be 4+)
  def combos([1, 3]), do: 1
  # There are 8 combos of the first 3 1-deltas, but we have to throw out the combo
  # that excludes all of them, to keep the total delta under 4.
  def combos([1, 1, 1, 1, 3]), do: 7
  # The first 2 1-deltas are optional, so 4 combos
  def combos([1, 1, 1, 3]), do: 4
  # The first 1-delta is optional, so 2 combos
  def combos([1, 1, 3]), do: 2
end
