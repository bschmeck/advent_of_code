defmodule Day12 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(12)
    |> Jason.decode!()
    |> Enum.map(&extract_numbers/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(12)
    |> Jason.decode!()
    |> Enum.map(&extract_non_red_numbers/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def extract_numbers(n) when is_integer(n), do: n
  def extract_numbers(list) when is_list(list), do: list |> Enum.map(&extract_numbers/1) |> Enum.reduce(&Kernel.+/2)
  def extract_numbers(map) when is_map(map), do: map |> Map.values() |> extract_numbers()
  def extract_numbers(_), do: 0

  def extract_non_red_numbers(n) when is_integer(n), do: n
  def extract_non_red_numbers(list) when is_list(list), do: list |> Enum.map(&extract_non_red_numbers/1) |> Enum.reduce(&Kernel.+/2)
  def extract_non_red_numbers(map) when is_map(map) do
    map
    |> Map.values()
    |> MapSet.new()
    |> MapSet.member?("red")
    |> case do
      true -> 0
      false -> extract_non_red_numbers(Map.values(map))
    end
  end
  def extract_non_red_numbers(_), do: 0
end
