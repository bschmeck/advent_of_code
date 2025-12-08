defmodule Day07 do
  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> split_beams()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> quantum_beams()
  end

  def split_beams(rows), do: split_beams(rows, 0, [])
  def split_beams([], splits, _beams), do: splits
  def split_beams([row | rest], splits, beams) do
    {splits, beams} = walk_row(row, beams, 0, splits, MapSet.new())
    split_beams(rest, splits, beams)
  end

  def walk_row([], _beams, _i, splits, acc) do
    beams = acc |> MapSet.to_list() |> Enum.sort()
    {splits, beams}
  end
  def walk_row(["S" | _rest], _beams, i, splits, _acc), do: {splits, [i]}
  def walk_row(["." | rest], [i | beams], i, splits, acc), do: walk_row(rest, beams, i+1, splits, MapSet.put(acc, i))
  def walk_row(["^" | rest], [i | beams], i, splits, acc), do: walk_row(rest, beams, i+1, splits+1, acc |> MapSet.put(i-1) |> MapSet.put(i+1))
  def walk_row([_elt | rest], beams, i, splits, acc), do: walk_row(rest, beams, i+1, splits, acc)

  def quantum_beams(rows), do: quantum_beams(rows, %{})
  def quantum_beams([], beams), do: beams |> Map.values() |> Enum.reduce(&Kernel.+/2)
  def quantum_beams([row | rest], beams), do: quantum_beams(rest, quantum_row(row, beams, 0, %{}))

  def quantum_row([], _beams, _i, acc), do: acc
  def quantum_row(["S" | _rest], _beams, i, _acc), do: %{i => 1}
  def quantum_row(["." | rest], beams, i, acc) do
    prev = Map.get(beams, i, 0)
    acc = Map.update(acc, i, prev, fn x -> x + prev end)
    quantum_row(rest, beams, i + 1, acc)
  end
  def quantum_row(["^" | rest], beams, i, acc) do
    prev = Map.get(beams, i, 0)
    acc = acc |> Map.update(i - 1, prev, fn x -> x + prev end) |> Map.update(i + 1, prev, fn x -> x + prev end)
    quantum_row(rest, beams, i + 1, acc)
  end
end
