defmodule Day05 do
  defmodule Mapping do
    defstruct [:func, :range]

    def build(dst, src, len) do
      %__MODULE__{func: fn val -> dst + val - src end, range: src..(src + len - 1)}
    end
  end

  def part_one(input \\ InputFile) do
    [seeds | raw_mappers] = input.contents_of(5) |> String.trim_trailing() |> String.split("\n\n")

    seeds = seeds |> String.replace_prefix("seeds: ", "") |> String.split(" ") |> Enum.map(&String.to_integer/1)

    raw_mappers
    |> Enum.map(&build_mappings/1)
    |> Enum.reduce(seeds, fn mapper, seeds -> Enum.map(seeds, fn seed -> map(seed, mapper) end) end)
    |> Enum.min()
  end

  def part_two(_input \\ InputFile) do

  end

  def map(val, mappers) do
    mapping = Enum.find(mappers, Mapping.build(val, val, 1), fn mapper -> val in mapper.range end)

    mapping.func.(val)
  end

  def build_mappings(raw) do
    raw
    |> String.split("\n")
    |> Kernel.tl()
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn pieces -> Enum.map(pieces, &String.to_integer/1) end)
    |> Enum.map(fn [dst, src, len] -> Mapping.build(dst, src, len) end)
  end
end
