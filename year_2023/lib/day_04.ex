defmodule Day04 do
  defmodule Parser do
    import NimbleParsec

    defparsec :card, ignore(string("Card")) |> ignore(repeat(string(" "))) |> integer(min: 1) |> ignore(string(": "))
  end

  def part_one(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&parse/1)
    |> Enum.map(fn {_id, nums} -> nums end)
    |> Enum.map(&score/1)
    |> Enum.sum
  end

  def part_two(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&parse/1)
    |> total(%{}, 0)
  end

  def parse(row) do
    {:ok, [id], rest, _, _, _} = Parser.card(row)

    nums = rest
    |> String.split(" | ")
    |> Enum.map(fn nums -> nums |> String.split() |> Enum.map(&String.to_integer/1) |> Enum.into(%MapSet{}) end)

    {id, nums}
  end

  def score([winners, given]) do
    case MapSet.intersection(winners, given) |> MapSet.size() do
      0 -> 0
      n -> 2 ** (n - 1)
    end
  end

  def total([], _copies, count), do: count
  def total([{id, [winners, given]} | rest], copies, count) do
    n = Map.get(copies, id, 0) + 1

    copies = MapSet.intersection(winners, given)
    |> Enum.with_index()
    |> Enum.reduce(copies, fn {_, i}, acc -> Map.update(acc, id + i + 1, n, fn existing -> existing + n end) end)
    |> Map.delete(id)

    total(rest, copies, count + n)
  end
end
