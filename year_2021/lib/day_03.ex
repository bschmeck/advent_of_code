defmodule Day03 do
  def part_one(input) do
    bits =
      input
      |> values_from()
      |> gamma()

    {decode(bits), decode(flip(bits))}
  end

  def part_one_nx(input) do
    input
    |> values_from()
    |> Stream.map(fn arr -> Enum.map(arr, &String.to_integer/1) end)
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(&Nx.tensor/1)
    |> Stream.map(&Nx.mean/1)
    |> Stream.map(&Nx.to_scalar/1)
    |> Enum.reduce({0, 0}, fn
      bit, {g, e} when bit < 0.5 -> {g * 2, e * 2 + 1}
      _, {g, e} -> {g * 2 + 1, e * 2}
    end)
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
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp rating(values, comp_fn, n) do
    {zeroes, ones} = Enum.split_with(values, fn [bit | _] -> bit == "0" end)

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
