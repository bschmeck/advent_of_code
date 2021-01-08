defmodule Day01 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(1)
    |> String.split("", trim: true)
    |> Enum.map(fn
      "(" -> 1
      ")" -> -1
    end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(1)
    |> String.split("", trim: true)
    |> Enum.map(fn
      "(" -> 1
      ")" -> -1
    end)
    |> detect_basement()
  end

  def detect_basement(steps), do: detect_basement(steps, 0, 0)
  defp detect_basement([-1 | _rest], 0, n), do: n + 1
  defp detect_basement([dir | rest], floor, n), do: detect_basement(rest, floor + dir, n + 1)
end
