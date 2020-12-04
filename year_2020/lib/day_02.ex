defmodule Day02 do
  def part_one do
    InputFile.contents_of(2, :stream)
    |> Enum.map(fn line -> parse(line) end)
    |> Enum.count(fn {policy, password} -> Day02.Policy.valid?(policy, password) end)
  end

  def part_two do
    InputFile.contents_of(2, :stream)
    |> Enum.map(fn line -> parse(line) end)
    |> Enum.count(fn {policy, password} -> Day02.Policy.indexes_valid?(policy, password) end)
  end

  defp parse(line) do
    {:ok, [min, max, char, password], _, _, _, _} = Day02.Parser.password_row(line)

    {%Day02.Policy{min: min, max: max, char: char}, password}
  end
end
