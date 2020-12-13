defmodule Day13 do
  def part_one(file_reader \\ InputFile) do
    [timestamp, shuttles, ""] =
      file_reader.contents_of(13)
      |> String.split("\n")

    timestamp = String.to_integer(timestamp)

    shuttles
    |> String.split(",")
    |> Enum.reject(&(&1 == "x"))
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn id -> [id, time_to_shuttle(timestamp, id)] end)
    |> Enum.min_by(fn [_, v] -> v end)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp time_to_shuttle(timestamp, t) when rem(timestamp, t) == 0, do: 0
  defp time_to_shuttle(timestamp, t), do: t - rem(timestamp, t)
end
