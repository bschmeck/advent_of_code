defmodule Day12 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(12)
    |> String.split("", trim: true)
    |> Enum.map(&to_integer/1)
    |> Enum.chunk_while({0, 1}, &chunk_fun/2, &after_fun/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def chunk_fun(nil, {total, sign}), do: {:cont, sign * total, {0, 1}}
  def chunk_fun("-", {0, 1}), do: {:cont, {0, -1}}
  def chunk_fun(digit, {total, sign}), do: {:cont, {10 * total + digit, sign}}
  def after_fun({total, sign}), do: {:cont, sign * total, {0, 1}}

  def to_integer("1"), do: 1
  def to_integer("2"), do: 2
  def to_integer("3"), do: 3
  def to_integer("4"), do: 4
  def to_integer("5"), do: 5
  def to_integer("6"), do: 6
  def to_integer("7"), do: 7
  def to_integer("8"), do: 8
  def to_integer("9"), do: 9
  def to_integer("0"), do: 0
  def to_integer("-"), do: "-"
  def to_integer(_), do: nil
end
