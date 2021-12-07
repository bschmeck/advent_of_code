defmodule Day07 do
  def part_one(input) do
    input
    |> positions()
    |> calculate(&modes_of/1, &linear_cost/2)
  end

  def part_two(input) do
    input
    |> positions()
    |> calculate(&avgs_of/1, &increasing_cost/2)
  end

  defp positions(input) do
    7
    |> input.contents_of()
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  defp calculate(positions, target_fn, cost_fn) do
    positions
    |> target_fn.()
    |> Enum.map(fn target ->
      positions
      |> Enum.map(fn pos -> cost_fn.(pos, target) end)
      |> Enum.reduce(&Kernel.+/2)
    end)
    |> Enum.min()
  end

  defp modes_of(l) do
    len = Enum.count(l)
    mid = div(len, 2)

    case rem(len, 2) do
      1 -> [Enum.at(l, mid)]
      0 -> [Enum.at(l, mid), Enum.at(l, mid - 1)] |> Enum.uniq()
    end
  end

  defp avgs_of(l) do
    sum = Enum.reduce(l, &Kernel.+/2)
    floor = div(sum, Enum.count(l))

    [floor, floor + 1]
  end

  defp linear_cost(from, to), do: abs(from - to)

  defp increasing_cost(from, to) do
    len = abs(from - to)
    div(len + len * len, 2)
  end
end
