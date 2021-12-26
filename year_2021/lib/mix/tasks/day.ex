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
  def run(["14.1"]), do: Day14.part_one(InputFile) |> IO.inspect()
  def run(["14.2"]), do: Day14.part_two(InputFile) |> IO.inspect()
  def run(["15.1"]), do: Day15.part_one(InputFile) |> IO.inspect()
  def run(["15.2"]), do: Day15.part_two(InputFile) |> IO.inspect()

  def run(["16.1"]) do
    16
    |> InputFile.contents_of()
    |> String.trim()
    |> Day16.version_sum()
    |> IO.inspect()
  end

  def run(["16.2"]) do
    16
    |> InputFile.contents_of()
    |> String.trim()
    |> Day16.compute()
    |> IO.inspect()
  end

  def run(["17.1"]), do: Day17.part_one(InputFile) |> IO.inspect()
  def run(["17.2"]), do: Day17.part_two(InputFile) |> IO.inspect()
  def run(["18.1"]), do: Day18.part_one(InputFile) |> IO.inspect()
  def run(["18.2"]), do: Day18.part_two(InputFile) |> IO.inspect()
  def run(["19.1"]), do: Day19.part_one(InputFile) |> IO.inspect()
  # def run(["19.2"]), do: Day19.part_two(InputFile) |> IO.inspect()
  def run(["20.1"]), do: Day20.part_one(InputFile) |> IO.inspect()
  def run(["20.2"]), do: Day20.part_two(InputFile) |> IO.inspect()
  def run(["21.1"]), do: Day21.part_one(InputFile) |> IO.inspect()
  def run(["21.2"]), do: Day21.part_two(InputFile) |> IO.inspect()
  def run(["22.1"]), do: Day22.part_one(InputFile) |> IO.inspect()
  def run(["22.2"]), do: Day22.part_two(InputFile) |> IO.inspect()
  def run(["25.1"]), do: Day25.part_one(InputFile) |> IO.inspect()

  def run(arg), do: Mix.raise("Day #{arg} has not been implemented.")
end
