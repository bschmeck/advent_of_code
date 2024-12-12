defmodule Day09 do
  defmodule File do
    defstruct [:number, :length]
  end

  defmodule Free do
    defstruct [:length]
  end

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

  def part_two(input \\ InputFile) do
    input.contents_of(9)
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 2, [0])
    |> Enum.with_index()
    |> Enum.flat_map(fn
      {[len, 0], n} -> [%File{number: n, length: len}]
      {[len, free], n} -> [%File{number: n, length: len}, %Free{length: free}]
    end)
    |> compact2([])
    |> checksum2(0, 0)
  end

  def compact([], compacted), do: Enum.reverse(compacted)
  def compact([{[len, _free], n}], compacted), do: Enum.reverse([[n, len, 0] | compacted])
  def compact([{[len, _free], n} | _rest]=drive, compacted) do
    [last | rest] = Enum.reverse(drive)
    compact(Enum.reverse(rest), last, [[n, len, 0] | compacted])
  end

  def compact([{[_len, free], _n} | rest], {[last_len, _last_free], last_n}, compacted) when free == last_len do
      compact(rest, [[last_n, free, 0] | compacted])
  end
  def compact([{[_len, free], _n} | rest], {[last_len, last_free], last_n}, compacted) when free < last_len do
    compact(rest ++ [{[last_len - free, last_free], last_n}], [[last_n, free, 0] | compacted])
  end
  def compact([{[_len, free], _n}], {[last_len, _last_free], last_n}, compacted) when free > last_len do
    compact([], [[last_n, last_len, 0] | compacted])
  end
  def compact([{[len, free], n} | rest], {[last_len, _last_free], last_n}, compacted) when free > last_len do
    [next_last | rest_rev] = Enum.reverse(rest)
    rest = [{[len, free - last_len], n} | Enum.reverse(rest_rev)]
    compact(rest, next_last, [[last_n, last_len, 0] | compacted])
  end

  def compact2([], tail), do: tail
  def compact2(drive, tail) do
    [last | rest] = Enum.reverse(drive)

    {drive, last} = place(Enum.reverse(rest), last)
    compact2(drive, [last | tail])
  end

  def place(drive, %Free{}=free), do: {drive, free}
  def place(drive, file), do: place(drive, file, [])
  def place([], file, head), do: {Enum.reverse(head), file}
  def place([%File{}=existing | rest], file, head), do: place(rest, file, [existing | head])
  def place([%Free{length: space}=free | rest], %File{length: len}=file, head) when len > space, do: place(rest, file, [free | head])
  def place([%Free{length: space} | rest], %File{length: len}=file, head) when len == space, do: {Enum.reverse(head) ++ [file | rest], %Free{length: len}}
  def place([%Free{length: space} | rest], %File{length: len}=file, head) when len < space, do: {Enum.reverse(head) ++ [file, %Free{length: space - len} | rest], %Free{length: len}}

  def checksum(drive), do: checksum(drive, 0, 0)
  def checksum([], _pos, total), do: total
  def checksum([[n, len, free] | rest], pos, total), do: checksum(rest, pos + len + free, div(n * len * (2 * pos + len - 1), 2) + total)

  def checksum2([], _pos, total), do: total
  def checksum2([%Free{length: len} | rest], pos, total), do: checksum2(rest, pos + len, total)
  def checksum2([%File{number: n, length: len} | rest], pos, total), do: checksum2(rest, pos + len, div(n * len * (2 * pos + len - 1), 2) + total)
end
