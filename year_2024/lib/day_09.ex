defmodule Day09 do
  def part_one(input \\ InputFile) do
    input.contents_of(9)
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 2, [0])
    |> Enum.with_index()
    |> compact([])
    |> checksum()
  end

  def part_two(_input \\ InputFile) do

  end

  def compact([], compacted), do: Enum.reverse(compacted)
  def compact([{[len, _free], n}], compacted), do: Enum.reverse([[n, len] | compacted])
  def compact([{[len, _free], n} | _rest]=drive, compacted) do
    [last | rest] = Enum.reverse(drive)
    compact(Enum.reverse(rest), last, [[n, len] | compacted])
  end

  def compact([{[_len, free], _n} | rest], {[last_len, _last_free], last_n}, compacted) when free == last_len do
      compact(rest, [[last_n, free] | compacted])
  end
  def compact([{[_len, free], _n} | rest], {[last_len, last_free], last_n}, compacted) when free < last_len do
    compact(rest ++ [{[last_len - free, last_free], last_n}], [[last_n, free] | compacted])
  end
  def compact([{[_len, free], _n}], {[last_len, _last_free], last_n}, compacted) when free > last_len do
    compact([], [[last_n, last_len] | compacted])
  end
  def compact([{[len, free], n} | rest], {[last_len, _last_free], last_n}, compacted) when free > last_len do
    [next_last | rest_rev] = Enum.reverse(rest)
    rest = [{[len, free - last_len], n} | Enum.reverse(rest_rev)]
    compact(rest, next_last, [[last_n, last_len] | compacted])
  end

  def checksum(drive), do: checksum(drive, 0, 0)
  def checksum([], _pos, total), do: total
  def checksum([[n, len] | rest], pos, total), do: checksum(rest, pos + len, div(n * len * (2 * pos + len - 1), 2) + total)
end
