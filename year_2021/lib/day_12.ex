defmodule Day12 do
  alias Day12.Path

  def part_one(input) do
    input
    |> graph_from()
    |> unique_paths([Path.new()], :part_one)
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> graph_from()
    |> unique_paths([Path.new()], :part_two)
    |> Enum.count()
  end

  def graph_from(input) do
    12
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "-"))
    |> Enum.reduce(%{}, fn [src, dest], graph -> add_path(graph, src, dest) end)
    |> Map.put("end", [])
  end

  def add_path(graph, src, "end"),
    do: Map.update(graph, src, ["end"], fn dests -> ["end" | dests] end)

  def add_path(graph, "end", src),
    do: Map.update(graph, src, ["end"], fn dests -> ["end" | dests] end)

  def add_path(graph, "start", dest),
    do: Map.update(graph, "start", [dest], fn dests -> [dest | dests] end)

  def add_path(graph, dest, "start"),
    do: Map.update(graph, "start", [dest], fn dests -> [dest | dests] end)

  def add_path(graph, src, dest) do
    graph
    |> Map.update(src, [dest], fn dests -> [dest | dests] end)
    |> Map.update(dest, [src], fn dests -> [src | dests] end)
  end

  def unique_paths(graph, paths, constraint) do
    if Enum.all?(paths, &Path.complete?/1) do
      paths
    else
      updated =
        paths
        |> Enum.flat_map(fn p ->
          if Path.complete?(p) do
            [p]
          else
            graph
            |> Map.fetch!(p.cave)
            |> Enum.flat_map(fn next_cave ->
              if Path.can_visit?(p, next_cave, constraint) do
                [Path.visit(p, next_cave)]
              else
                []
              end
            end)
          end
        end)

      unique_paths(graph, updated, constraint)
    end
  end
end
