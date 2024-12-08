defmodule Day07 do
  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&parse/1)
    |> Enum.filter(&valid?/1)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def parse(line) do
    [value, raw] = String.split(line, ": ")
    value = String.to_integer(value)
    [first | rest] = String.split(raw, " ", trim: true) |> Enum.map(&String.to_integer/1)

    {value, first, rest}
  end

  def valid?({value, total, []}), do: value == total
  def valid?({value, total, _rest}) when value < total, do: false
  def valid?({value, total, [num | rest]}), do: valid?({value, total + num, rest}) || valid?({value, total * num, rest})
end
