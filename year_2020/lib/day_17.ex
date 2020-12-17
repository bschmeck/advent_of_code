defmodule Day17 do
  def part_one(file_reader \\ InputFile) do
    final = file_reader.contents_of(17)
    |> Day17.PocketDimension.parse()
    |> run_simulation(6)

    Enum.count(final.grid)
  end

  def run_simulation(dim, 0), do: dim
  def run_simulation(dim, n) do
    dim
    |> Day17.PocketDimension.simulate()
    |> run_simulation(n - 1)
  end
end
