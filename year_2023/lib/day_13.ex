import Bitwise

defmodule Day13 do
  def part_one(input \\ InputFile) do
    input.contents_of(13)
    |> String.split("\n\n")
    |> Enum.map(fn raw -> vertical_reflection(raw) + 100 * horizontal_reflection(raw) end)
    |> Enum.sum()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(13)
    |> String.split("\n\n")
    |> Enum.map(fn raw -> vertical_reflection(raw, true) + 100 * horizontal_reflection(raw, true) end)
    |> Enum.sum()
  end

  def vertical_reflection(raw, smudge \\ false) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> String.split(row, "", trim: true) end)
    |> Enum.zip_reduce([], fn elts, acc -> [elts | acc] end)
    |> Enum.reverse()
    |> Enum.map(&row_to_int/1)
    |> reflection(smudge)
  end

  def horizontal_reflection(raw, smudge \\ false) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> String.split(row, "", trim: true) end)
    |> Enum.map(&row_to_int/1)
    |> reflection(smudge)
  end

  def reflection(rows, false), do: reflection([hd(rows)], tl(rows), 1)
  def reflection(rows, true), do: smudged([hd(rows)], tl(rows), 1)

  def reflection(_left, [], _row), do: 0
  def reflection(left, right, row) do
    if reflected?(left, right), do: row, else: reflection([hd(right) | left], tl(right), row + 1)
  end

  def reflected?([], _), do: true
  def reflected?(_, []), do: true
  def reflected?([elt | left], [elt | right]), do: reflected?(left, right)
  def reflected?(_, _), do: false

  def smudged(_left, [], _row), do: 0
  def smudged(left, right, row) do
    if reflected_with_smudge?(left, right), do: row, else: smudged([hd(right) | left], tl(right), row + 1)
  end

  def reflected_with_smudge?([], _), do: false
  def reflected_with_smudge?(_, []), do: false
  def reflected_with_smudge?([a | left], [a | right]), do: reflected_with_smudge?(left, right)
  def reflected_with_smudge?([a | left], [b | right]) when (abs(a - b) &&& (abs(a - b) - 1)) == 0, do: reflected?(left, right)
  def reflected_with_smudge?(_, _), do: false

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
