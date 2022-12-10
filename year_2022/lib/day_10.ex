defmodule Day10 do
  def part_one(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> simulate(0, fn {cycle, x}, accum -> accum + signal_strength(cycle, x) end)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> simulate([], fn {cycle, x}, accum -> [pixel_at(cycle, x) | accum] end)
    |> Enum.reverse()
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  defp simulate(instrs, accum, func), do: simulate(instrs, {1, 1}, accum, func)
  defp simulate([], _vaules, accum, _func), do: accum
  defp simulate(["noop" | rest], {cycle, x}, accum, func), do: simulate(rest, {cycle + 1, x}, func.({cycle, x}, accum), func)
  defp simulate(["addx " <> amt | rest], {cycle, x}, accum, func) do
    amt = String.to_integer(amt)
    accum = func.({cycle, x}, accum)
    accum = func.({cycle + 1, x}, accum)

    simulate(rest, {cycle + 2, x + amt}, accum, func)
  end

  defp signal_strength(cycle, x) when rem(cycle, 40) == 20, do: cycle * x
  defp signal_strength(_cycle, _x), do: 0

  defp pixel_at(cycle, x) when abs(rem(cycle - 1, 40) - x) <= 1, do: "#"
  defp pixel_at(_cycle, _x), do: "."
end
