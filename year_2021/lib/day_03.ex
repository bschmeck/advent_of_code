defmodule Day03 do
  def part_one(input) do
    bits = gamma(input)
    {decode(bits), decode(flip(bits))}
  end

  def part_two(input) do
    {oxygen_rating(input), co2_rating(input)}
  end

  def oxygen_rating(input) do
    3
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> do_oxygen_rating(0)
  end

  def co2_rating(input) do
    3
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> do_co2_rating(0)
  end

  defp do_oxygen_rating([elt], _n), do: elt |> encode |> decode

  defp do_oxygen_rating(values, n) do
    %{"0" => zeroes, "1" => ones} = Enum.group_by(values, fn arr -> Enum.fetch!(arr, n) end)

    if Enum.count(ones) >= Enum.count(zeroes) do
      do_oxygen_rating(ones, n + 1)
    else
      do_oxygen_rating(zeroes, n + 1)
    end
  end

  defp do_co2_rating([elt], _n), do: elt |> encode |> decode

  defp do_co2_rating(values, n) do
    %{"0" => zeroes, "1" => ones} = Enum.group_by(values, fn arr -> Enum.fetch!(arr, n) end)

    if Enum.count(ones) < Enum.count(zeroes) do
      do_co2_rating(ones, n + 1)
    else
      do_co2_rating(zeroes, n + 1)
    end
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
