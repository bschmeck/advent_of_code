defmodule Day05.Diagnostics do
  def run(input) do
    "#{__DIR__}/input.txt"
    |> Intcode.from_file
    |> Intcode.execute(input)
    :ok
  end
end
