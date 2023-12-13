defmodule Day13 do
  def part_one(input \\ InputFile) do
    input.contents_of(13)
    |> String.split("\n\n")
    |> Enum.map(fn raw -> vertical_reflection(raw) + 100 * horizontal_reflection(raw) end)
    |> Enum.sum()
  end

  def part_two(_input \\ InputFile) do

  end

  def vertical_reflection(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> String.split(row, "", trim: true) end)
    |> Enum.zip_reduce([], fn elts, acc -> [elts | acc] end)
    |> Enum.reverse()
    |> Enum.map(&row_to_int/1)
    |> reflection()
  end

  def horizontal_reflection(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> String.split(row, "", trim: true) end)
    |> Enum.map(&row_to_int/1)
    |> reflection()
  end

  def reflection(rows), do: reflection([hd(rows)], tl(rows), 1)
  def reflection(_left, [], _row), do: 0
  def reflection([elt | left], [elt | right], row) do
    if reflected?(left, right), do: row, else: reflection([elt | [elt | left]], right, row + 1)
  end
  def reflection(left, [elt | right], row), do: reflection([elt | left], right, row + 1)

  def reflected?([], _), do: true
  def reflected?(_, []), do: true
  def reflected?([elt | left], [elt | right]), do: reflected?(left, right)
  def reflected?(_, _), do: false

  def row_to_int(row) do
    row
    |> Enum.map(fn
      "#" -> 1
      "." -> 0
    end)
    |> Enum.join("")
    |> String.to_integer(2)
  end
end
