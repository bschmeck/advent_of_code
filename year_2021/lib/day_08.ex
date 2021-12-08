defmodule Day08 do
  @digits %{
    "abcefg" => 0,
    "cf" => 1,
    "acdeg" => 2,
    "acdfg" => 3,
    "bcdf" => 4,
    "abdfg" => 5,
    "abdefg" => 6,
    "acf" => 7,
    "abcdefg" => 8,
    "abcdfg" => 9
  }

  @translator %{
    [2, 3, 4, 5, 5, 6, 6, 6, 7] => "f",
    [2, 3, 4, 5, 5, 6, 6, 7] => "c",
    [3, 5, 5, 5, 6, 6, 6, 7] => "a",
    [4, 5, 5, 5, 6, 6, 7] => "d",
    [4, 5, 6, 6, 6, 7] => "b",
    [5, 5, 5, 6, 6, 6, 7] => "g",
    [5, 6, 6, 7] => "e"
  }

  def part_one(input) do
    input
    |> lines
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.flat_map(&String.split/1)
    |> Enum.frequencies_by(&String.length/1)
    |> Map.take([2, 3, 4, 7])
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input) do
    input
    |> lines
    |> Enum.map(fn [signals, display] ->
      mapping = signals |> String.split() |> infer()

      display
      |> String.split()
      |> Enum.map(&translate(&1, mapping))
      |> number_from()
    end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def translate(segments, mapping) do
    segments
    |> String.codepoints()
    |> Enum.map(&mapping[&1])
    |> Enum.sort()
    |> Enum.join()
    |> then(&@digits[&1])
  end

  def number_from(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, n} -> digit * :math.pow(10, n) end)
    |> Enum.reduce(&Kernel.+/2)
    |> floor()
  end

  def infer(signals) do
    signals
    |> Enum.map(fn s ->
      s
      |> String.codepoints()
      |> Enum.map(fn c -> {c, [String.length(s)]} end)
      |> Enum.into(%{})
    end)
    |> Enum.reduce(fn m1, m2 -> Map.merge(m1, m2, fn _k, v1, v2 -> Enum.sort(v1 ++ v2) end) end)
    |> Enum.map(fn {k, v} -> {k, @translator[v]} end)
    |> Enum.into(%{})
  end

  defp lines(input) do
    8
    |> input.contents_of(:stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " | "))
  end
end
