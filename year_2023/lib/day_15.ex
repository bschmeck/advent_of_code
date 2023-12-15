defmodule Day15 do
  def part_one(input \\ InputFile) do
    input.contents_of(15)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(15)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn op ->
      if String.ends_with?(op, "-") do
        {:rem, String.replace_suffix(op, "-", "")}
      else
        [a, b] = String.split(op, "=")
        {:add, {a, String.to_integer(b)}}
      end
    end)
    |> Enum.reduce(%{}, fn
      {:rem, op}, boxes -> Map.update(boxes, hash(op), [], fn contents -> remove(op, contents, []) end)
      {:add, {op, f}}, boxes -> Map.update(boxes, hash(op), [{op, f}], fn contents -> insert({op, f}, contents, []) end)
    end)
    |> Enum.flat_map(fn {box, contents} ->
      contents
      |> Enum.with_index(1)
      |> Enum.map(fn {{_op, f}, i} -> (box + 1) * i * f end)
    end)
    |> Enum.sum()
  end

  def hash(string) do
    string
    |> String.to_charlist
    |> Enum.reduce(0, fn ascii, acc -> rem((acc + ascii) * 17, 256) end)
  end

  def remove(op, [{op, _f} | rest], prev), do: Enum.reverse(prev) ++ rest
  def remove(_op, [], prev), do: Enum.reverse(prev)
  def remove(op, [elt | rest], prev), do: remove(op, rest, [elt | prev])

  def insert({op, f}, [{op, _old_f} | rest], prev), do: Enum.reverse(prev) ++ [{op, f} | rest]
  def insert({op, f}, [], prev), do: Enum.reverse([{op, f} | prev])
  def insert({op, f}, [elt | rest], prev), do: insert({op, f}, rest, [elt | prev])
end
