defmodule Day20 do
  def part_one(input \\ InputFile) do
    elts = input.contents_of(20, :stream)
    |> Enum.map(&String.to_integer/1)

    size = Enum.count(elts)

    elts
    |> Enum.reduce(Enum.to_list(elts), fn elt, list -> move(list, elt, size) end)
    |> coords()
    |> Enum.sum()
  end

  def part_two(_input \\ InputFile) do

  end

  def move(list, elt), do: move(list, elt, Enum.count(list))
  def move(list, elt, size) do
    {head_rev, tail} = find(list, [], elt)
    List.insert_at(tail ++ Enum.reverse(head_rev), index(elt, size), elt)
    # move(head_rev, tail, elt, rem(elt, size - 1))
  end

  def index(elt, size) when elt >= 0, do: rem(elt, size - 1)
  def index(elt, size), do: rem(elt, size - 1) - 1

  def move([], tail, elt, 0), do: tail ++ [elt]
  def move(head_rev, [], elt, 0), do: Enum.reverse([elt | head_rev])
  def move(head_rev, tail, elt, 0), do: Enum.reverse(head_rev) ++ [elt | tail]
  def move(head_rev, [], elt, count) when count > 0, do: move([], Enum.reverse(head_rev), elt, count)
  def move(head_rev, [t | tail], elt, count) when count > 0, do: move([t | head_rev], tail, elt, count - 1)
  def move([], tail, elt, count) when count < 0, do: move(Enum.reverse(tail), [], elt, count)
  def move([h | head_rev], tail, elt, count) when count < 0, do: move(head_rev, [h | tail], elt, count + 1)

  def find([elt | rest], prev, elt), do: {prev, rest}
  def find([other | rest], prev, elt), do: find(rest, [other | prev], elt)

  def coords(list), do: coords(list, [], -1, [])
  def coords([], prev, count, found), do: prev |> Enum.reverse() |> coords([], count, found)
  def coords([0 | rest], prev, -1, found), do: coords(rest, [0 | prev], 1, found)
  def coords([h | rest], prev, -1, found), do: coords(rest, [h | prev], -1, found)
  def coords([h | rest], prev, 1_000, found), do: coords(rest, [h | prev], 1_001, [h | found])
  def coords([h | rest], prev, 2_000, found), do: coords(rest, [h | prev], 2_001, [h | found])
  def coords([h | _rest], _prev, 3_000, found), do: [h | found]
  def coords([h | rest], prev, count, found), do: coords(rest, [h | prev], count + 1, found)
end
