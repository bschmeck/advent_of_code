defmodule Day05 do
  def part_one(input \\ InputFile) do
    moved = move(stacks(input), steps(input))

    Map.keys(moved)
    |> Enum.map(&Map.get(moved, &1))
    |> Enum.map(&hd/1)
    |> Enum.join
  end

  def part_two(input \\ InputFile) do
    moved = move_multi(stacks(input), steps(input))

    Map.keys(moved)
    |> Enum.map(&Map.get(moved, &1))
    |> Enum.map(&hd/1)
    |> Enum.join
  end

  def stacks(input) do
    rows = input.contents_of(5, :stream)
    |> Enum.take_while(fn l -> l != "" end) #Regex.match?(~r{\s+\[}, l) end)

    width = rows |> Enum.map(fn a -> String.length(a) end) |> Enum.max()

    rows
    |> Enum.map(fn l -> String.pad_trailing(l, width) end)
    |> Enum.map(fn l -> String.split(l, "") |> tl() |> Enum.reverse() |> tl() |> Enum.reverse() end)
    |> Enum.map(fn l -> Enum.chunk_every(l, 4) |> Enum.map(fn chunk -> Enum.join(chunk) end) end)
    |> Enum.map(fn l -> Enum.map(l, &String.trim/1) end)
    |> Enum.map(fn l -> Enum.map(l, &String.trim(&1, "[")) end)
    |> Enum.map(fn l -> Enum.map(l, &String.trim(&1, "]")) end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn row -> Enum.reject(row, &(&1 == "")) end)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reduce(%{}, fn [num | rest], h -> Map.put(h, num, Enum.reverse(rest)) end)
  end

  def steps(input) do
    input.contents_of(5, :stream)
    |> Enum.drop_while(fn l -> !String.starts_with?(l, "move") end)
    |> Enum.map(fn l -> Regex.named_captures(~r{move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)}, l) end)
    |> Enum.map(fn %{"from" => f, "count" => c, "to" => t} -> {String.to_integer(c), f, t} end)
  end

  defp move(stacks, []), do: stacks
  defp move(stacks, [{0, _, _} | rest]), do: move(stacks, rest)
  defp move(stacks, [{count, from, to} | rest]), do: move(move_crate(stacks, from, to), [{count - 1, from, to} | rest])

  defp move_crate(stacks, from, to) do
    {crate, stacks} = Map.get_and_update(stacks, from, fn l -> {hd(l), tl(l)} end)
    Map.update!(stacks, to, fn l -> [crate | l] end)
  end

  defp move_multi(stacks, []), do: stacks
  defp move_multi(stacks, [op | rest]), do: stacks |> move_multi_crates(op) |> move_multi(rest)

  defp move_multi_crates(stacks, {count, from, to}) do
    {crates, stacks} = Map.get_and_update(stacks, from, fn l -> {Enum.take(l, count), Enum.drop(l, count)} end)
    Map.update!(stacks, to, fn l -> crates ++ l end)
  end
end
