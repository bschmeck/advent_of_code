defmodule Day03 do
  def part_one(input \\ InputTestFile) do
    totals = input.contents_of(3, :stream)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn row, acc -> parse(row, acc) end)

    input.contents_of(3, :stream)
    |> Enum.with_index
    |> Enum.flat_map(fn {row, y} -> part_locations(row, y) end)
    |> Enum.map(fn loc -> Map.get(totals, loc, 0) |> Enum.sum() end)
    |> Enum.sum
  end

  def part_two(input \\ InputTestFile) do
    totals = input.contents_of(3, :stream)
    |> Enum.with_index
    |> Enum.reduce(%{}, fn row, acc -> parse(row, acc) end)

    input.contents_of(3, :stream)
    |> Enum.with_index
    |> Enum.flat_map(fn {row, y} -> gear_locations(row, y) end)
    |> Enum.map(fn loc -> Map.get(totals, loc, 0) end)
    |> Enum.map(fn
      [a, b] -> a * b
      _ -> 0
    end)
    |> Enum.sum
  end

  def parse({row, y}, totals) do
    row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> parse_nums([], {0, []})
    |> Enum.reduce(totals, fn num, acc -> populate(acc, num, y) end)
  end

  defp parse_nums([], nums, {0, _xs}), do: Enum.reverse(nums)
  defp parse_nums([], nums, n), do: Enum.reverse([n | nums])
  defp parse_nums([{digit, x} | rest], nums, {n, xs}) when digit in ~w[0 1 2 3 4 5 6 7 8 9], do: parse_nums(rest, nums, {n * 10 + String.to_integer(digit), [x | xs]})
  defp parse_nums([{_, _x} | rest], nums, {0, _set}), do: parse_nums(rest, nums, {0, []})
  defp parse_nums([{_, _x} | rest], nums, n), do: parse_nums(rest, [n | nums], {0, []})

  def populate(map, {n, xs}, y) do
    exclude = Enum.map(xs, fn x -> {x, y} end) |> Enum.into(%MapSet{})

    (for y_delta <- [-1, 0, 1], x_delta <- [-1, 0, 1], x <- xs, do: {x + x_delta, y + y_delta})
    |> Enum.reject(fn {x, y} -> x < 0 || y < 0 end)
    |> Enum.into(%MapSet{})
    |> MapSet.difference(exclude)
    |> Enum.reduce(map, fn point, acc -> Map.update(acc, point, [n], &([n | &1])) end)
  end

  def part_locations(row, y) do
    row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.reject(fn {char, _x} -> char in ~w[. 0 1 2 3 4 5 6 7 8 9] end)
    |> Enum.map(fn {_char, x} -> {x, y} end)
  end

  def gear_locations(row, y) do
    row
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.filter(fn {char, _x} -> char == "*" end)
    |> Enum.map(fn {_char, x} -> {x, y} end)
  end
end
