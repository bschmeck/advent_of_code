defmodule Day03 do
  def part_one(input) do
    bits =
      input
      |> values_from()
      |> gamma()

    {decode(bits), decode(flip(bits))}
  end

  def part_two(input) do
    values = values_from(input)
    o2 = oxygen_rating(values)
    co2 = co2_rating(values)
    {o2, co2}
  end

  defp oxygen_rating(values, n \\ 0)
  defp oxygen_rating([elt], _n), do: elt |> encode |> decode

  defp oxygen_rating(values, n) do
    %{"0" => zeroes, "1" => ones} = Enum.group_by(values, fn arr -> Enum.fetch!(arr, n) end)

    if Enum.count(ones) >= Enum.count(zeroes) do
      oxygen_rating(ones, n + 1)
    else
      oxygen_rating(zeroes, n + 1)
    end
  end

  defp co2_rating(values, n \\ 0)
  defp co2_rating([elt], _n), do: elt |> encode |> decode

  defp co2_rating(values, n) do
    %{"0" => zeroes, "1" => ones} = Enum.group_by(values, fn arr -> Enum.fetch!(arr, n) end)

    if Enum.count(ones) < Enum.count(zeroes) do
      co2_rating(ones, n + 1)
    else
      co2_rating(zeroes, n + 1)
    end
  end

  def decode(arr) do
    Enum.reduce(arr, 0, fn
      x, tot when x > 0 -> tot * 2 + 1
      _, tot -> tot * 2
    end)
  end

  defp gamma(values) do
    values
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

  defp values_from(input) do
    3
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
  end
end
