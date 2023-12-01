defmodule Day01 do
  def part_one(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(fn line -> extract_digits(line) end)
    |> Enum.map(fn digits -> [hd(digits), hd(Enum.reverse(digits))] end)
    |> Enum.map(fn [tens, ones] -> tens * 10 + ones end)
    |> Enum.sum
  end

  def part_two(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(fn line -> extract_written_digits(line) end)
    |> Enum.map(fn digits -> [hd(digits), hd(Enum.reverse(digits))] end)
    |> Enum.map(fn [tens, ones] -> tens * 10 + ones end)
    |> Enum.sum
  end

  def extract_digits(line) do
    line
    |> String.split("", trim: true)
    |> Enum.filter(&Regex.match?(~r/[[:digit:]]/, &1))
    |> Enum.map(&String.to_integer/1)
  end

  def extract_written_digits(line), do: extract_written_digits(line, [])
  defp extract_written_digits("", digits), do: Enum.reverse(digits)
  defp extract_written_digits("1" <> rest, digits), do: extract_written_digits(rest, [1 | digits])
  defp extract_written_digits("2" <> rest, digits), do: extract_written_digits(rest, [2 | digits])
  defp extract_written_digits("3" <> rest, digits), do: extract_written_digits(rest, [3 | digits])
  defp extract_written_digits("4" <> rest, digits), do: extract_written_digits(rest, [4 | digits])
  defp extract_written_digits("5" <> rest, digits), do: extract_written_digits(rest, [5 | digits])
  defp extract_written_digits("6" <> rest, digits), do: extract_written_digits(rest, [6 | digits])
  defp extract_written_digits("7" <> rest, digits), do: extract_written_digits(rest, [7 | digits])
  defp extract_written_digits("8" <> rest, digits), do: extract_written_digits(rest, [8 | digits])
  defp extract_written_digits("9" <> rest, digits), do: extract_written_digits(rest, [9 | digits])
  defp extract_written_digits("one" <> rest, digits), do: extract_written_digits("e" <> rest, [1 | digits])
  defp extract_written_digits("two" <> rest, digits), do: extract_written_digits("o" <> rest, [2 | digits])
  defp extract_written_digits("three" <> rest, digits), do: extract_written_digits("e" <> rest, [3 | digits])
  defp extract_written_digits("four" <> rest, digits), do: extract_written_digits(rest, [4 | digits])
  defp extract_written_digits("five" <> rest, digits), do: extract_written_digits("e" <> rest, [5 | digits])
  defp extract_written_digits("six" <> rest, digits), do: extract_written_digits(rest, [6 | digits])
  defp extract_written_digits("seven" <> rest, digits), do: extract_written_digits("n" <> rest, [7 | digits])
  defp extract_written_digits("eight" <> rest, digits), do: extract_written_digits("t" <> rest, [8 | digits])
  defp extract_written_digits("nine" <> rest, digits), do: extract_written_digits("e" <> rest, [9 | digits])
  defp extract_written_digits(<<_::binary-size(1)>> <> rest, digits), do: extract_written_digits(rest, digits)
end
