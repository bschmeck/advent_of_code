defmodule Day01 do
  def part_one(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(fn line -> extract_digits(line) end)
    |> Enum.map(fn digits -> [hd(digits), hd(Enum.reverse(digits))] end)
    |> Enum.map(fn [tens, ones] -> String.to_integer(tens) * 10 + String.to_integer(ones) end)
    |> Enum.sum
  end

  def extract_digits(line) do
    line
    |> String.split("", trim: true)
    |> Enum.filter(&Regex.match?(~r/[[:digit:]]/, &1))
  end
end
