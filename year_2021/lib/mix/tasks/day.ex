defmodule Mix.Tasks.Day do
  @shortdoc "Executes the solution for a given day"

  use Mix.Task

  @impl Mix.Task
  def run(["1.1"]), do: Day01.part_one(InputFile) |> IO.inspect()
  def run(["1.2"]), do: Day01.part_two(InputFile) |> IO.inspect()

  def run(["2.1"]) do
    {x, y} = Day02.navigate(InputFile)
    IO.puts("Final answer: #{x * y}")
  end

  def run(["2.2"]) do
    {x, y} = Day02.navigate_with_aim(InputFile)
    IO.puts("Final answer: #{x * y}")
  end

  def run(["3.1"]) do
    {gamma, epsilon} = Day03.part_one(InputFile)
    IO.puts("Final answer: #{gamma * epsilon}")
  end

  def run(arg), do: Mix.raise("Day #{arg} has not been implemented.")
end
