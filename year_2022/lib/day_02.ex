defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(&String.trim_trailing(&1))
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(&score(&1))
    |> Enum.reduce(0, &Kernel.+/2)
  end

  defp score([them, us]), do: outcome(them, us) + shape_score(us)

  defp shape_score("X"), do: 1
  defp shape_score("Y"), do: 2
  defp shape_score("Z"), do: 3

  defp outcome("A", "X"), do: 3
  defp outcome("A", "Y"), do: 6
  defp outcome("A", "Z"), do: 0
  defp outcome("B", "X"), do: 0
  defp outcome("B", "Y"), do: 3
  defp outcome("B", "Z"), do: 6
  defp outcome("C", "X"), do: 6
  defp outcome("C", "Y"), do: 0
  defp outcome("C", "Z"), do: 3
end
