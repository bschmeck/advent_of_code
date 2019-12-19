defmodule Mix.Tasks.Day do
  def run(["1.1"]), do: Day01.Fuel.run(:required)
  def run(["1.2"]), do: Day01.Fuel.run(:total)
  def run(["2.1"]), do: Day02.Intcode.run(:part1)
  def run(["2.2"]), do: Day02.Intcode.run(:part2)
  def run(["3.1"]), do: Day03.Wires.run(:part1)
  def run(["3.2"]), do: Day03.Wires.run(:part2)
  def run(["4.1"]), do: Day04.Password.run(:part1)
  def run(["4.2"]), do: Day04.Password.run(:part2)
  def run(["5.1"]), do: Day05.Diagnostics.run(1)
  def run(["5.2"]), do: Day05.Diagnostics.run(5)
  def run(["6.1"]), do: Day06.Orbits.count_input()
  def run(["6.2"]), do: Day06.Orbits.run(:part2)
  def run(["7.1"]), do: Day07.SignalMaximizer.run(Day07.Amplifier, [0,1,2,3,4]) |> IO.puts
  def run(["7.2"]), do: Day07.SignalMaximizer.run(Day07.LoopedAmplifier, [5,6,7,8,9]) |> IO.puts
  def run(["8.1"]), do: Day08.SpaceImageFormat.checksum({25, 6}) |> IO.puts
  def run(["8.2"]), do: Day08.SpaceImageFormat.print({25, 6})
  def run(["9.1"]), do: Day09.Boost.run(1)
  def run(["9.2"]), do: Day09.Boost.run(2)
  def run(["10.1"]), do: Day10.Asteroids.run(1)
  def run(["10.2"]), do: Day10.Asteroids.run(2)
  def run(["11.1"]), do: Day11.Robot.panel_count() |> IO.inspect
end
