defmodule Day06 do
  def simulate(input, days) do
    6
    |> input.contents_of()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.group_by(& &1)
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
    |> Enum.into(%{})
    |> run(days)
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  defp run(world, 0), do: world

  defp run(world, days) do
    world
    |> Enum.reduce(%{}, fn
      {0, v}, h -> h |> Map.put(6, v) |> Map.put(8, v)
      {k, v}, h -> Map.update(h, k - 1, v, &(&1 + v))
    end)
    |> run(days - 1)
  end
end
