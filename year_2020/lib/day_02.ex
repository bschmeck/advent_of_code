defmodule Day02 do
  def part_one do
    InputFile.contents_of(2, :stream)
    |> Enum.map(fn(line) -> parse(line) end)
    |> Enum.count(fn({policy, password}) -> Day02.Policy.valid?(policy, password) end)
  end

  def part_two do
    InputFile.contents_of(2, :stream)
    |> Enum.map(fn(line) -> parse(line) end)
    |> Enum.count(fn({policy, password}) -> Day02.Policy.indexes_valid?(policy, password) end)
  end

  defp parse(line) do
    parts = Regex.named_captures(~r/(?<min>\d+)-(?<max>\d+) (?<char>.): (?<password>.*)/, line)

    {
      %Day02.Policy{min: parts |> Map.get("min") |> String.to_integer(), max: parts |> Map.get("max") |> String.to_integer(), char: Map.get(parts, "char")},
      Map.get(parts, "password")
    }
  end
end
