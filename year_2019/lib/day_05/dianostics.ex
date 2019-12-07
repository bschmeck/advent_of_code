defmodule Day05.Diagnostics do
  def run(input) do
    {:ok, raw} = File.read("#{__DIR__}/input.txt")
    raw |> Intcode.build |> Intcode.execute(input)
    :ok
  end
end
