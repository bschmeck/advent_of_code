defmodule Day09 do
  def part_one(file_reader \\ InputFile, preamble_len \\ 25) do
    stream(file_reader)
    |> Enum.split(preamble_len)
    |> find_weakness()
  end

  def part_two(file_reader \\ InputFile, preamble_len \\ 25) do
    stream = stream(file_reader)

    weakness =
      stream
      |> Enum.split(preamble_len)
      |> find_weakness()

    find_encryption_weakness(stream, weakness)
  end

  defp stream(file_reader) do
    file_reader.contents_of(9, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp find_weakness({stream, [n | rest]}) do
    set = Enum.into(stream, MapSet.new())

    stream
    |> Enum.any?(fn a -> MapSet.member?(set, n - a) && n != a * 2 end)
    |> case do
      true -> find_weakness({tl(stream) ++ [n], rest})
      _ -> n
    end
  end

  defp find_encryption_weakness(stream, target) do
    case find_encryption_weakness_seq(stream, target, []) do
      nil ->
        find_encryption_weakness(tl(stream), target)

      arr ->
        {a, b} = Enum.min_max(arr)
        a + b
    end
  end

  defp find_encryption_weakness_seq(_stream, 0, sequence), do: sequence
  defp find_encryption_weakness_seq([n | _rest], target, _sequence) when n > target, do: nil

  defp find_encryption_weakness_seq([n | rest], target, sequence),
    do: find_encryption_weakness_seq(rest, target - n, [n | sequence])
end
