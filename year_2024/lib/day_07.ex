defmodule Day07 do
  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&parse/1)
    |> Enum.filter(&valid?/1)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&parse/1)
    |> Enum.filter(&valid2?/1)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.reduce(&Kernel.+/2)
  end

  def parse(line) do
    [value, raw] = String.split(line, ": ")
    value = String.to_integer(value)
    nums = String.split(raw, " ", trim: true) |> Enum.map(&String.to_integer/1)

    {value, nums}
  end

  def valid?({value, [num]}), do: value == num
  def valid?({value, [a, b | rest]}) do
    valid?({value, [a + b | rest]}) ||
      valid?({value, [a * b | rest]})
  end

  def valid2?({value, [num]}), do: value == num
  def valid2?({value, [a, b | rest]}) do
    valid2?({value, [a + b | rest]}) ||
      valid2?({value, [a * b | rest]}) ||
      valid2?({value, [combine(a, b) | rest]})
  end

  def combine(a, b) when b < 10, do: a * 10 + b
  def combine(a, b) when b < 100, do: a * 100 + b
  def combine(a, b) when b < 1000, do: a * 1000 + b
end
