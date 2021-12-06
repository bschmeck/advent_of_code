defmodule Day04 do
  alias Day04.Board

  def part_one(input) do
    {calls, boards} = parse(input)

    boards
    |> Enum.map(fn b -> Board.call_all(b, calls) end)
    |> Enum.min_by(fn {i, _score} -> i end)
    |> then(fn {_i, score} -> score end)
  end

  def part_two(input) do
    {calls, boards} = parse(input)

    boards
    |> Enum.map(fn b -> Board.call_all(b, calls) end)
    |> Enum.max_by(fn {i, _score} -> i end)
    |> then(fn {_i, score} -> score end)
  end

  defp parse(input) do
    4
    |> input.contents_of()
    |> String.split("\n\n")
    |> then(fn [calls | boards] ->
      {String.split(calls, ","), Enum.map(boards, &Board.parse/1)}
    end)
  end
end
