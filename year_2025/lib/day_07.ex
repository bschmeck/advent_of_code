defmodule Day07 do
  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> split_beams()
  end

  def part_two(_input \\ InputFile) do

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
end
