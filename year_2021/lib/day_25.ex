defmodule Day25 do
  def part_one(input) do
    map =
      25
      |> input.contents_of(:stream)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, "", trim: true))
      |> Stream.with_index()
      |> Stream.flat_map(fn {line, y} ->
        line
        |> Enum.with_index()
        |> Enum.reject(fn {char, _x} -> char == "." end)
        |> Enum.map(fn {char, x} -> {{x, y}, char} end)
      end)
      |> Enum.into(%{})

    dim_x = map |> Map.keys() |> Enum.map(&elem(&1, 0)) |> Enum.max()
    dim_y = map |> Map.keys() |> Enum.map(&elem(&1, 1)) |> Enum.max()

    map
    |> advance(dim_x, dim_y)
  end

  defp advance(map, dim_x, dim_y) do
    next_map =
      map
      |> advance_dir(">", fn {x, y} -> {rem(x + 1, dim_x + 1), y} end)
      |> advance_dir("v", fn {x, y} -> {x, rem(y + 1, dim_y + 1)} end)

    if map == next_map do
      1
    else
      advance(next_map, dim_x, dim_y) + 1
    end
  end

  defp advance_dir(map, dir, advancer) do
    map
    |> Enum.map(fn
      {{x, y}, ^dir} ->
        pt = advancer.({x, y})

        if Map.has_key?(map, pt) do
          {{x, y}, dir}
        else
          {pt, dir}
        end

      cucumber ->
        cucumber
    end)
    |> Enum.into(%{})
  end
end
