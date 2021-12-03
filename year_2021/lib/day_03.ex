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
    o2 = rating(values, fn ones, zeroes -> Enum.count(ones) >= Enum.count(zeroes) end)
    co2 = rating(values, fn ones, zeroes -> Enum.count(ones) < Enum.count(zeroes) end)
    {o2, co2}
  end

  defp rating(values, comp_fn, n \\ [])

  defp rating([elt], _comp_fn, n) do
    n
    |> Enum.reverse(elt)
    |> encode
    |> decode
  end

  defp rating(values, comp_fn, n) do
    %{"0" => zeroes, "1" => ones} = Enum.group_by(values, &hd/1)

    if comp_fn.(ones, zeroes) do
      rating(Enum.map(ones, &tl/1), comp_fn, ["1" | n])
    else
      rating(Enum.map(zeroes, &tl/1), comp_fn, ["0" | n])
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
