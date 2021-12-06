defmodule Day06 do
  def simulate(input, days) do
    6
    |> input.contents_of()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> do_simulate(days, [])
    |> Enum.count()
  end

  defp do_simulate(fish, 0, _next_gen), do: fish
  defp do_simulate([], n, fish), do: do_simulate(fish, n - 1, [])
  defp do_simulate([0 | rest], n, next_gen), do: do_simulate(rest, n, [6, 8 | next_gen])
  defp do_simulate([f | rest], n, next_gen), do: do_simulate(rest, n, [f - 1 | next_gen])
end
