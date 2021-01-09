defmodule Day06 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> follow(%{}, &parse/1)
    |> Map.values()
    |> Enum.count(fn x -> x == 1 end)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> follow(%{}, &parse2/1)
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def follow([], grid, _parser), do: grid
  def follow([instr | rest], grid, parser) do
    {op, range} = parser.(instr)

    grid = Enum.reduce(range, grid, op)
    follow(rest, grid, parser)
  end

  def parse(<<"turn on ", raw_range :: binary>>), do: {fn pt, grid -> Map.put(grid, pt, 1) end, parse_range(raw_range)}
  def parse(<<"turn off ", raw_range :: binary>>), do: {fn pt, grid -> Map.put(grid, pt, -1) end, parse_range(raw_range)}
  def parse(<<"toggle ", raw_range :: binary>>), do: {fn pt, grid -> Map.update(grid, pt, 1, fn x -> -x end) end, parse_range(raw_range)}

  def parse2(<<"turn on ", raw_range :: binary>>), do: {fn pt, grid -> Map.update(grid, pt, 1, fn x -> x + 1 end) end, parse_range(raw_range)}
  def parse2(<<"turn off ", raw_range :: binary>>), do: {fn pt, grid -> Map.update(grid, pt, 0, fn x -> Enum.max([x - 1, 0]) end) end, parse_range(raw_range)}
  def parse2(<<"toggle ", raw_range :: binary>>), do: {fn pt, grid -> Map.update(grid, pt, 2, fn x -> x + 2 end) end, parse_range(raw_range)}

  def parse_range(raw) do
    [[low_x, low_y], [hi_x, hi_y]] = String.split(raw, " through ") |> Enum.map(fn pt -> pt |> String.split(",") |> Enum.map(&String.to_integer/1) end)
    for x <- low_x..hi_x do
      for y <- low_y..hi_y, do: {x, y}
    end |> Enum.concat()
  end
end
