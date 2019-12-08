defmodule Day05.Diagnostics do
  def run(input) do
    InputFile.contents_of(5)
    |> Intcode.build
    |> Intcode.execute(input)
    :ok
  end
end
