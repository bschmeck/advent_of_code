defmodule Day07 do
  def part_one do
    InputFile.contents_of(7, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse/1)
    |> Enum.map(&invert/1)
    |> Enum.reduce(fn a, b -> Map.merge(a, b, fn _k, c, d -> c ++ d end) end)
    |> containers(["shiny gold"], MapSet.new())
    |> Enum.count
  end

  def part_two do
    InputFile.contents_of(7, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse/1)
    |> Enum.reduce(%{}, fn({color, content}, rules) -> Map.put(rules, color, content) end)
    |> count("shiny gold")
    |> Kernel.-(1)
  end

  def parse(line) do
    ~r/^(?<color>.*) bags contain (?<contents>.*)\.$/
    |> Regex.named_captures(line)
    |> captures_to_rule()
  end

  def invert({color, contents}), do: invert(color, contents, %{})
  def invert(_color, [], map), do: map
  def invert(color, [content | rest], map), do: invert(color, rest, Map.put(map, content.color, [color]))

  def containers(_map, [], seen), do: seen
  def containers(map, colors, seen) do
    new = colors
    |> Enum.flat_map(&(Map.get(map, &1, [])))
    |> Enum.reject(&(MapSet.member?(seen, &1)))

    containers(map, new, Enum.into(new, seen))
  end

  defp captures_to_rule(%{"color" => color, "contents" => "no other bags"}), do: {color, []}
  defp captures_to_rule(%{"color" => color, "contents" => contents}), do: {color, contents |> String.split(",") |> extract_contents()}

  defp extract_contents(raw), do: extract_contents(raw, [])
  defp extract_contents([], contents), do: contents
  defp extract_contents([str | rest], contents) do
    c = Day07.Contents.parse(str)
    extract_contents(rest, [c | contents])
  end

  defp count(rules, bag_color) do
    {:ok, contents} = Map.fetch(rules, bag_color)

    1 + Enum.reduce(contents, 0, fn(content, total) -> total + content.number * count(rules, content.color) end)
  end
end
