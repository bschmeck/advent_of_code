defmodule Day11 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(11, :stream)
    |> Enum.map(&String.trim/1)
    |> Day11.Seats.new()
    |> Day11.Seats.stabilize(ignore_floor: false, threshold: 4)
    |> Day11.Seats.count_empty_seats()
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(11, :stream)
    |> Enum.map(&String.trim/1)
    |> Day11.Seats.new()
    |> Day11.Seats.stabilize(ignore_floor: true, threshold: 5)
    |> Day11.Seats.count_empty_seats()
  end

  def print(grid) do
    for i <- 0..9 do
      pts = for j <- 0..9, do: {i, j}

      pts
      |> Enum.map(fn pos -> Map.get(grid, pos) end)
      |> Enum.join()
      |> IO.puts()
    end
  end
end
