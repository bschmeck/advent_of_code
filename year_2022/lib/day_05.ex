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
    input.contents_of(5, :stream)
    |> Enum.take_while(fn l -> l != "" end)
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&Kernel.tl/1)
    |> Enum.map(fn l -> Enum.take_every(l, 4) end)
    |> build([[]])
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
  defp move(stacks, [{count, from, to} | rest]) do
    stacks
    |> move_crates({1, from, to})
    |> move([{count - 1, from, to} | rest])
  end

  defp move_multi(stacks, []), do: stacks
  defp move_multi(stacks, [op | rest]) do
    stacks
    |> move_crates(op)
    |> move_multi(rest)
  end

  defp move_crates(stacks, {count, from, to}) do
    {crates, stacks} = Map.get_and_update(stacks, from, fn l -> {Enum.take(l, count), Enum.drop(l, count)} end)
    Map.update!(stacks, to, fn l -> crates ++ l end)
  end

  defp build([], built), do: built
  defp build(rows, built), do: build(rows, built, [])
  defp build([[] | rest], built, prev), do: build(rest, Enum.reverse(prev) ++ built)
  defp build([[" " | row] | rest], [s | stacks], prev), do: build([row | rest], stacks, [s | prev])
  defp build([[crate | row] | rest], [s | stacks], prev), do: build([row | rest], stacks, [[crate | s] | prev])
  defp build([[crate | row] | rest], [], prev), do: build([row | rest], [], [[crate] | prev])
end
