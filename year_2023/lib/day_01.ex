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
    |> Enum.map(fn line -> [first_digit(line), last_digit(String.reverse(line))] end)
    |> Enum.map(fn [tens, ones] -> tens * 10 + ones end)
    |> Enum.sum
  end

  def extract_digits(line) do
    line
    |> String.split("", trim: true)
    |> Enum.filter(&Regex.match?(~r/[[:digit:]]/, &1))
    |> Enum.map(&String.to_integer/1)
  end

  def first_digit("1" <> _rest), do: 1
  def first_digit("2" <> _rest), do: 2
  def first_digit("3" <> _rest), do: 3
  def first_digit("4" <> _rest), do: 4
  def first_digit("5" <> _rest), do: 5
  def first_digit("6" <> _rest), do: 6
  def first_digit("7" <> _rest), do: 7
  def first_digit("8" <> _rest), do: 8
  def first_digit("9" <> _rest), do: 9
  def first_digit("one" <> _rest), do: 1
  def first_digit("two" <> _rest), do: 2
  def first_digit("three" <> _rest), do: 3
  def first_digit("four" <> _rest), do: 4
  def first_digit("five" <> _rest), do: 5
  def first_digit("six" <> _rest), do: 6
  def first_digit("seven" <> _rest), do: 7
  def first_digit("eight" <> _rest), do: 8
  def first_digit("nine" <> _rest), do: 9
  def first_digit(<<_::binary-size(1)>> <> rest), do: first_digit(rest)

  def last_digit("1" <> _rest), do: 1
  def last_digit("2" <> _rest), do: 2
  def last_digit("3" <> _rest), do: 3
  def last_digit("4" <> _rest), do: 4
  def last_digit("5" <> _rest), do: 5
  def last_digit("6" <> _rest), do: 6
  def last_digit("7" <> _rest), do: 7
  def last_digit("8" <> _rest), do: 8
  def last_digit("9" <> _rest), do: 9
  def last_digit("eno" <> _rest), do: 1
  def last_digit("owt" <> _rest), do: 2
  def last_digit("eerht" <> _rest), do: 3
  def last_digit("ruof" <> _rest), do: 4
  def last_digit("evif" <> _rest), do: 5
  def last_digit("xis" <> _rest), do: 6
  def last_digit("neves" <> _rest), do: 7
  def last_digit("thgie" <> _rest), do: 8
  def last_digit("enin" <> _rest), do: 9
  def last_digit(<<_::binary-size(1)>> <> rest), do: last_digit(rest)
end
