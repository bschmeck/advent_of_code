defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> String.split(line, " ") |> Enum.map(&translate/1) end)
    |> Enum.map(&score(&1))
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> String.split(line, " ") |> choose() end)
    |> Enum.map(&score(&1))
    |> Enum.reduce(0, &Kernel.+/2)
  end

  defp choose([them, "X"]), do: loser(them)
  defp choose([them, "Y"]), do: draw(them)
  defp choose([them, "Z"]), do: winner(them)

  defp loser("A"), do: [:rock, :scissors]
  defp loser("B"), do: [:paper, :rock]
  defp loser("C"), do: [:scissors, :paper]
  defp draw(them), do: [translate(them), translate(them)]
  defp winner("A"), do: [:rock, :paper]
  defp winner("B"), do: [:paper, :scissors]
  defp winner("C"), do: [:scissors, :rock]


  defp translate("A"), do: :rock
  defp translate("B"), do: :paper
  defp translate("C"), do: :scissors
  defp translate("X"), do: :rock
  defp translate("Y"), do: :paper
  defp translate("Z"), do: :scissors

  defp score([them, us]), do: outcome(them, us) + shape_score(us)

  defp shape_score(:rock), do: 1
  defp shape_score(:paper), do: 2
  defp shape_score(:scissors), do: 3

  defp outcome(shape, shape), do: 3
  defp outcome(:rock, :paper), do: 6
  defp outcome(:rock, :scissors), do: 0
  defp outcome(:paper, :rock), do: 0
  defp outcome(:paper, :scissors), do: 6
  defp outcome(:scissors, :rock), do: 6
  defp outcome(:scissors, :paper), do: 0
end
