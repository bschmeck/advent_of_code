defmodule Day05 do
  defmodule Mapping do
    defstruct [:func, :range, :min, :max]

    def build(dst, src, len) do
      %__MODULE__{func: fn val -> dst + val - src end, range: src..(src + len - 1), min: src, max: src + len - 1}
    end
  end

  def part_one(input \\ InputFile) do
    [seeds | raw_mappers] = input.contents_of(5) |> String.trim_trailing() |> String.split("\n\n")

    seeds = seeds
    |> String.replace_prefix("seeds: ", "")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&({&1, &1}))

    raw_mappers
    |> Enum.map(&build_mappings/1)
    |> Enum.reduce(seeds, fn mappings, seeds -> map(mappings, seeds) end)
    |> Enum.map(fn {min, _max} -> min end)
    |> Enum.min()
  end

  def part_two(input \\ InputFile) do
    [seeds | raw_mappers] = input.contents_of(5) |> String.trim_trailing() |> String.split("\n\n")

    seeds = seeds
    |> String.replace_prefix("seeds: ", "")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [min, size] -> {min, min + size - 1} end)

    raw_mappers
    |> Enum.map(&build_mappings/1)
    |> Enum.reduce(seeds, fn mappings, seeds -> map(mappings, seeds) end)
    |> Enum.map(fn {min, _max} -> min end)
    |> Enum.min()
  end

  def map(mappings, seeds), do: map(mappings, [], seeds)
  defp map([], mapped, seeds), do: mapped ++ seeds
  defp map([mapping | mappers], mapped, seeds) do
    {new_mapped, seeds} = apply_mapping(mapping, seeds, [], [])
    map(mappers, new_mapped ++ mapped, seeds)
  end

  def build_mappings(raw) do
    raw
    |> String.split("\n")
    |> Kernel.tl()
    |> Enum.map(fn line -> String.split(line, " ") end)
    |> Enum.map(fn pieces -> Enum.map(pieces, &String.to_integer/1) end)
    |> Enum.map(fn [dst, src, len] -> Mapping.build(dst, src, len) end)
  end

  def apply_mapping(_mapping, [], mapped, unmapped), do: {mapped, unmapped}
  def apply_mapping(mapping, [seed | rest], mapped, unmapped) do
    case transform(seed, mapping) do
      nil -> apply_mapping(mapping, rest, mapped, [seed | unmapped])
      {new_mapped, seeds} -> apply_mapping(mapping, rest, [new_mapped | mapped], seeds ++ unmapped)
    end
  end

  def transform({min, max}, mapping) do
    cond do
      max < mapping.min -> nil
      min > mapping.max -> nil
      min in mapping.range and max in mapping.range -> {{mapping.func.(min), mapping.func.(max)}, []}
      min in mapping.range and max not in mapping.range -> {{mapping.func.(min), mapping.func.(mapping.max)}, [{mapping.max + 1, max}]}
      min not in mapping.range and max in mapping.range -> {{mapping.func.(mapping.min), mapping.func.(max)}, [{min, mapping.min - 1}]}
      min < mapping.min and max > mapping.max -> {{mapping.func.(mapping.min), mapping.func.(mapping.max)}, [{min, mapping.min - 1}, {mapping.max + 1, max}]}
    end
  end
end
