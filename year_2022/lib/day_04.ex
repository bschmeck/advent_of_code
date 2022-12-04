defmodule Day04 do
  def part_one(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&parse_assignments/1)
    |> Enum.count(&fully_contained?/1)
  end

  defp parse_assignments(line) do
    match = Regex.named_captures(~r/(?<min1>\d+)-(?<max1>\d+),(?<min2>\d+)-(?<max2>\d+)/, line)
    [{String.to_integer(Map.get(match, "min1")),
      String.to_integer(Map.get(match, "max1"))},
     {String.to_integer(Map.get(match, "min2")),
      String.to_integer(Map.get(match, "max2"))}]
  end

  defp fully_contained?([{min1, max1}, {min2, max2}]) do
    (min1 <= min2 && max1 >= max2) || (min2 <= min1 && max2 >= max1)
  end
end
