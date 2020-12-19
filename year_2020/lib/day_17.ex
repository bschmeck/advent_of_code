defmodule Day17 do
  def part_one(file_reader \\ InputFile) do
    perform(file_reader, Day17.PocketDimension)
  end

  def part_two(file_reader \\ InputFile) do
    perform(file_reader, Day17.PocketDimension4D)
  end

  def perform(file_reader, dimension_mod) do
    final =
      file_reader.contents_of(17)
      |> dimension_mod.parse()
      |> run_simulation(6, &dimension_mod.simulate/1)

    Enum.count(final.grid)
  end

  def run_simulation(dim, 0, _simulator), do: dim

  def run_simulation(dim, n, simulator) do
    dim
    |> simulator.()
    |> run_simulation(n - 1, simulator)
  end
end
