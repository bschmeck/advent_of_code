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

  def run(["3.2"]) do
    {o2, co2} = Day03.part_two(InputFile)
    IO.puts("Final answer: #{o2 * co2}")
  end

  def run(["4.1"]), do: Day04.part_one(InputFile) |> IO.inspect()
  def run(["4.2"]), do: Day04.part_two(InputFile) |> IO.inspect()
  def run(["5.1"]), do: Day05.part_one(InputFile) |> IO.inspect()
  def run(["5.2"]), do: Day05.part_two(InputFile) |> IO.inspect()
  def run(["6.1"]), do: Day06.simulate(InputFile, 80) |> IO.inspect()
  def run(["6.2"]), do: Day06.simulate(InputFile, 256) |> IO.inspect()
  def run(["7.1"]), do: Day07.part_one(InputFile) |> IO.inspect()
  def run(["7.2"]), do: Day07.part_two(InputFile) |> IO.inspect()
  def run(["8.1"]), do: Day08.part_one(InputFile) |> IO.inspect()
  def run(["8.2"]), do: Day08.part_two(InputFile) |> IO.inspect()
  def run(["9.1"]), do: Day09.part_one(InputFile) |> IO.inspect()
  def run(["9.2"]), do: Day09.part_two(InputFile) |> IO.inspect()
  def run(["10.1"]), do: Day10.part_one(InputFile) |> IO.inspect()
  def run(["10.2"]), do: Day10.part_two(InputFile) |> IO.inspect()
  def run(["11.1"]), do: Day11.part_one(InputFile, 100) |> IO.inspect()
  def run(["11.2"]), do: Day11.part_two(InputFile) |> IO.inspect()
  def run(["12.1"]), do: Day12.part_one(InputFile) |> IO.inspect()
  def run(["12.2"]), do: Day12.part_two(InputFile) |> IO.inspect()
  def run(["13.1"]), do: Day13.part_one(InputFile) |> IO.inspect()
  def run(["13.2"]), do: Day13.part_two(InputFile)

  def run(arg), do: Mix.raise("Day #{arg} has not been implemented.")
end
