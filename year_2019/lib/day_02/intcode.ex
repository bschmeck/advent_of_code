defmodule Day02.Intcode do
  def run(:part1) do
    InputFile.contents_of(2)
    |> Intcode.build
    |> compute(12, 2)
    |> IO.puts
  end

  def run(:part2) do
    machine = InputFile.contents_of(2) |> Intcode.build
    target = 19690720
    combos = for x <- 0..99, y <- 0..99, into: [], do: {x, y}

    {noun, verb} = combos
    |> Enum.find(fn({noun, verb}) -> compute(machine, noun, verb) == target end)

    IO.puts noun * 100 + verb
  end

  def compute(machine, noun, verb) do
    machine
    |> Intcode.write(1, noun)
    |> Intcode.write(2, verb)
    |> Intcode.execute
    |> Intcode.read(0)
  end
end
