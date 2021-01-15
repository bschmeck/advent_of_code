defmodule Day17 do
  def part_one(file_reader \\ InputFile, liters \\ 150) do
    containers = file_reader.contents_of(17, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    combos(containers, liters)
    |> Enum.count(fn combo -> Enum.reduce(combo, &Kernel.+/2) == liters end)
  end

  def part_two(file_reader \\ InputFile, liters \\ 150) do
    containers = file_reader.contents_of(17, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    combos(containers, liters)
    |> Enum.filter(fn combo -> Enum.reduce(combo, &Kernel.+/2) == liters end)
    |> Enum.map(&Enum.count/1)
    |> count_min()
  end

  def count_min([first | rest]), do: count_min(rest, first, 1)
  def count_min([], _min, count), do: count
  def count_min([min | rest], min, count), do: count_min(rest, min, count + 1)
  def count_min([elt | rest], min, count) when elt > min, do: count_min(rest, min, count)
  def count_min([elt | rest], min, _count) when elt < min, do: count_min(rest, elt, 1)

  def combos([container | rest], liters) when container > liters, do: combos(rest, liters)
  def combos([container | rest], liters) when container <= liters, do: combos(rest, liters, [[container]])
  def combos([], _liters, ret), do: ret
  def combos([container | rest], liters, ret) do
    expanded = Enum.flat_map(ret, fn lst ->
      case liters - Enum.reduce(lst, &Kernel.+/2) do
        x when x >= container -> [lst, [container | lst]]
        _ -> [lst]
      end
    end)

    combos(rest, liters, [[container] | expanded])
  end
end
