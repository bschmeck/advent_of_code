defmodule Day04 do
  alias Day04.Board

  def part_one(input) do
    {calls, boards} =
      4
      |> input.contents_of()
      |> String.split("\n\n")
      |> then(fn [calls | boards] -> {calls, Enum.map(boards, &Board.parse/1)} end)
  end
end
