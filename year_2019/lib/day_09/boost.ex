defmodule Day09.Boost do
  def run(input) do
    9
    |> InputFile.contents_of
    |> Intcode.build
    |> Intcode.execute([input])
  end
end
