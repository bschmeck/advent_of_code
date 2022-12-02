defmodule Day01 do
  def part_one(input \\ InputFile) do
    input
    |> calories_per_elf()
    |> Enum.max()
  end

  def part_two(input \\ InputFile) do
    input
    |> calories_per_elf()
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.reduce(0, fn a, b -> a + b end)
  end

  defp calories_per_elf(input) do
    input.contents_of(1, :stream)
    |> Enum.reduce([0], fn
      "", totals -> [0 | totals]
      raw, [total | rest] ->
        cals = Integer.parse(raw) |> elem(0)
        [cals + total | rest]
    end)
  end
end
