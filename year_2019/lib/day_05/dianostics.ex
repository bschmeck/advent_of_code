defmodule Day05.Diagnostics do
  def run do
    {:ok, raw} = File.read("#{__DIR__}/input.txt")
    raw |> Intcode.build |> Intcode.execute
  end
end
