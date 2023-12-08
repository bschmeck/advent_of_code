defmodule Day08 do
  defmodule Parser do
    import NimbleParsec

    node_str = ascii_string([?A..?Z], 3)

    defparsec :map_line, node_str |> ignore(string(" = (")) |> concat(node_str) |> ignore(string(", ")) |> concat(node_str) |> ignore(string(")"))
  end

  def part_one(input \\ InputFile) do
    [turns, map] = input.contents_of(8) |> String.split("\n\n")

    map = map
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&Parser.map_line/1)
    |> Enum.map(fn {:ok, [node, left, right], "", %{}, _, _} -> {node, %{"L" => left, "R" => right}} end)
    |> Map.new

    turns
    |> String.split("", trim: true)
    |> Stream.cycle
    |> Stream.transform(Map.fetch!(map, "AAA"), fn
      "L", %{"L" => "ZZZ"} -> {:halt, nil}
      "R", %{"R" => "ZZZ"} -> {:halt, nil}
      "L", %{"L" => next_node} -> {[1], Map.fetch!(map, next_node)}
      "R", %{"R" => next_node} -> {[1], Map.fetch!(map, next_node)}
    end)
    |> Enum.sum
    |> Kernel.+(1)
  end

  def part_two(input \\ InputFile) do
    [turns, map] = input.contents_of(8) |> String.split("\n\n")

    map = map
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&Parser.map_line/1)
    |> Enum.map(fn {:ok, [node, left, right], "", %{}, _, _} -> {node, %{"L" => left, "R" => right}} end)
    |> Map.new

    map
    |> Map.keys
    |> Enum.filter(fn key -> String.last(key) == "A" end)
    |> Enum.map(fn node ->
      turns
      |> String.split("", trim: true)
      |> Stream.cycle
      |> Stream.transform(Map.fetch!(map, node), fn
        "L", %{"L" => <<_prefix::binary-size(2)>><>"Z"} -> {:halt, nil}
        "R", %{"R" => <<_prefix::binary-size(2)>><>"Z"} -> {:halt, nil}
        "L", %{"L" => next_node} -> {[1], Map.fetch!(map, next_node)}
        "R", %{"R" => next_node} -> {[1], Map.fetch!(map, next_node)}
      end)
      |> Enum.sum
      |> Kernel.+(1)
    end)
    |> Enum.map(fn x -> div(x, String.length(turns)) end)
    |> Enum.reduce(fn x, y -> x * y end)
    |> Kernel.*(String.length(turns))
  end
end
