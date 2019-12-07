defmodule Mix.Tasks.Day do
  def run(["1.1"]), do: Day01.Fuel.run(:required)
  def run(["1.2"]), do: Day01.Fuel.run(:total)
  def run(["2.1"]), do: Day02.Intcode.run(:part1)
  def run(["2.2"]), do: Day02.Intcode.run(:part2)
  def run(["3.1"]), do: Day05.Diagnostics.run(1)
  def run(["3.2"]), do: Day05.Diagnostics.run(5)
  def run(["4.1"]), do: Day05.Diagnostics.run(1)
  def run(["4.2"]), do: Day05.Diagnostics.run(5)
  def run(["5.1"]), do: Day05.Diagnostics.run(1)
  def run(["5.2"]), do: Day05.Diagnostics.run(5)
end
