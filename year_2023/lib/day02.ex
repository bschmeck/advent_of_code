defmodule Day02 do
  defmodule Parser do
    import NimbleParsec

    defparsec :game, ignore(string("Game ")) |> integer(min: 1) |> ignore(string(": "))
    defparsec :set, integer(min: 1) |> ignore(string(" ")) |> choice([string("blue"), string("green"), string("red")])
  end

  defmodule Set do
    defstruct red: 0, green: 0, blue: 0

    def parse(raw) do
      String.split(raw, ", ")
      |> Enum.map(&Parser.set/1)
      |> Enum.map(fn {:ok, [count, color], "", _, _, _} -> [count, color] end)
      |> Enum.reduce(%__MODULE__{}, fn
        [n, "blue"], acc -> %__MODULE__{acc | blue: n}
        [n, "red"], acc -> %__MODULE__{acc | red: n}
        [n, "green"], acc -> %__MODULE__{acc | green: n}
        end)
    end
  end

  defmodule Game do
    defstruct [:id, :sets]

    def parse(row) do
      {:ok, [id], rest, _, _, _} = Parser.game(row)

      sets = String.split(rest, "; ") |> Enum.map(&Set.parse(&1))

      %__MODULE__{id: id, sets: sets}
    end
  end

  def part_one(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> Game.parse(line) end)
    |> Enum.filter(fn game -> possible?(game) end)
    |> Enum.map(&(&1.id))
    |> Enum.sum
  end

  def part_two(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> Game.parse(line) end)
    |> Enum.map(fn game -> minimum_possible(game) end)
    |> Enum.map(fn %Set{} = s -> s.red * s.green * s.blue end)
    |> Enum.sum
  end

  def possible?(game) do
    game.sets
    |> Enum.all?(fn %Set{red: r, green: g, blue: b} -> r <= 12 && g <= 13 && b <= 14 end)
  end

  def minimum_possible(game) do
    game.sets
    |> Enum.reduce(fn set, max -> %Set{red: Enum.max([set.red, max.red]),
                                    green: Enum.max([set.green, max.green]),
                                    blue: Enum.max([set.blue, max.blue])} end)
  end
end
