defmodule Day10 do
  def part_one(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> signal_strength({1, 1}, 0)
  end

  def part_two(_input \\ InputFile) do

  end

  defp signal_strength([], _values, sum), do: sum
  defp signal_strength(["noop" | rest], {cycle, x}, sum) when rem(cycle, 40) == 20, do: signal_strength(rest, {cycle + 1, x}, sum + cycle * x)
  defp signal_strength(["noop" | rest], {cycle, x}, sum), do: signal_strength(rest, {cycle + 1, x}, sum)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum) when rem(cycle, 40) == 20, do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum + cycle * x)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum) when rem(cycle, 40) == 19, do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum + (cycle + 1) * x)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum), do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum)
end
