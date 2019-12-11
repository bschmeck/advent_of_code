defmodule Day09.Boost do
  def run do
    9
    |> InputFile.contents_of
    |> Intcode.build
    |> Intcode.execute
  end
end
