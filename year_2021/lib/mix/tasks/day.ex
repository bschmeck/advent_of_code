defmodule Mix.Tasks.Day do
  @shortdoc "Executes the solution for a given day"

  use Mix.Task

  @impl Mix.Task
  def run(["1.1"]), do: IO.puts("Run Day 1.1")
  def run(arg), do: Mix.raise("Day #{arg} has not been implemented.")
end
