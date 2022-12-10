defmodule Day10 do
  def part_one(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> signal_strength({1, 1}, 0)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> draw_pixels({1, 1}, [])
    |> Enum.chunk_every(40)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  defp signal_strength([], _values, sum), do: sum
  defp signal_strength(["noop" | rest], {cycle, x}, sum) when rem(cycle, 40) == 20, do: signal_strength(rest, {cycle + 1, x}, sum + cycle * x)
  defp signal_strength(["noop" | rest], {cycle, x}, sum), do: signal_strength(rest, {cycle + 1, x}, sum)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum) when rem(cycle, 40) == 20, do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum + cycle * x)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum) when rem(cycle, 40) == 19, do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum + (cycle + 1) * x)
  defp signal_strength(["addx " <> amt | rest], {cycle, x}, sum), do: signal_strength(rest, {cycle + 2, x + String.to_integer(amt)}, sum)

  defp draw_pixels([], _values, pixels), do: Enum.reverse(pixels)
  defp draw_pixels(["noop" | rest], {cycle, x}, pixels), do: draw_pixels(rest, {cycle + 1, x}, [pixel_at(cycle, x) | pixels])
  defp draw_pixels(["addx " <> amt | rest], {cycle, x}, pixels), do: draw_pixels(rest, {cycle + 2, x + String.to_integer(amt)}, [pixel_at(cycle + 1, x), pixel_at(cycle, x) | pixels])

  defp pixel_at(cycle, x) when abs(rem(cycle - 1, 40) - x) <= 1, do: "#"
  defp pixel_at(_cycle, _x), do: "."
end
