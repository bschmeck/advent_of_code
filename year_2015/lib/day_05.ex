defmodule Day05 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(5, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.count(&nice?/1)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(5, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.count(&nice2?/1)
  end

  def nice?(str) do
    vowels(str) >= 3 &&
      repeated_letter?(str) &&
      !naughty_substring?(str)
  end

  def nice2?(str) do
    repeated_pair?(str) &&
      spaced_repetition?(str)
  end

  def repeated_pair?(str) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(2, 1)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {pair, indx}, map -> Map.update(map, pair, [indx], fn arr -> [indx | arr] end) end)
    |> Map.values
    |> Enum.reject(fn l -> Enum.count(l) == 1 end)
    |> Enum.any?(fn indexes ->
      Enum.count(indexes) > 2 || hd(indexes) - hd(tl(indexes)) > 1
    end)
  end

  def spaced_repetition?(str) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(3, 1)
    |> Enum.any?(fn
      [a, b, a] when a != b -> true
      _ -> false
    end)
  end

  def vowels(str) do
    str
    |> String.split("", trim: true)
    |> Enum.filter(fn
      "a" -> true
      "e" -> true
      "i" -> true
      "o" -> true
      "u" -> true
      _ -> false
    end)
    |> Enum.count
  end

  def repeated_letter?(str) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.any?(fn [a, b] -> a == b end)
  end

  def naughty_substring?(str) do
    Regex.match?(~r/(ab|cd|pq|xy)/, str)
  end
end
