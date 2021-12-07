defmodule Day07 do
  def part_one(input) do
    positions =
      7
      |> input.contents_of()
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    positions
    |> modes_of()
    |> Enum.map(fn mode ->
      positions
      |> Enum.map(fn pos -> abs(mode - pos) end)
      |> Enum.reduce(&Kernel.+/2)
    end)
    |> Enum.min()
  end

  def part_two(input) do
    positions =
      7
      |> input.contents_of()
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    positions
    |> avgs_of()
    |> Enum.map(fn avg ->
      positions
      |> Enum.map(fn pos -> cost(pos, avg) end)
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

  defp cost(from, to) do
    len = abs(from - to)

    case rem(len, 2) do
      0 -> (1 + len) * len / 2
      1 -> (1 + len) * (len - 1) / 2 + (len + 1) / 2
    end
  end
end
