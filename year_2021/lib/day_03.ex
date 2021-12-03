defmodule Day03 do
  def part_one(input) do
    bits = gamma(input)
    {decode(bits), decode(flip(bits))}
  end

  def decode(arr) do
    Enum.reduce(arr, 0, fn
      x, tot when x > 0 -> tot * 2 + 1
      _, tot -> tot * 2
    end)
  end

  defp gamma(input) do
    3
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Stream.map(&encode/1)
    |> Enum.reduce(&sum_cols/2)
  end

  defp flip(arr) do
    Enum.map(arr, &(-&1))
  end

  defp encode(arr) do
    Enum.map(arr, fn
      "0" -> -1
      "1" -> 1
    end)
  end

  defp sum_cols(a, b) do
    Enum.zip(a, b)
    |> Enum.map(fn {x, y} -> x + y end)
  end
end
