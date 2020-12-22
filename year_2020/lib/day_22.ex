defmodule Day22 do
  def part_one(file_reader \\ InputFile), do: play(file_reader, Day22.Game)
  def part_two(file_reader \\ InputFile), do: play(file_reader, Day22.RecursiveGame)

  def play(file_reader, game_module) do
    file_reader.contents_of(22, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(struct(game_module), fn line, game -> game_module.build(game, line) end)
    |> game_module.prepare()
    |> game_module.play()
  end
end
