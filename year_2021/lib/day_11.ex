defmodule Day11 do
  def part_one(input, steps) do
    octopi = parse(input)

    step(octopi, steps, 0)
  end

  def part_two(input) do
    octopi = parse(input)

    find_synchronized(octopi, Enum.count(octopi), 1)
  end

  def find_synchronized(octopi, goal, steps) do
    {octopi, flashed} =
      octopi
      |> increase_all()
      |> flash()

    if Enum.count(flashed) == goal do
      steps
    else
      flashed
      |> Enum.reduce(octopi, fn k, m -> Map.put(m, k, 0) end)
      |> find_synchronized(goal, steps + 1)
    end
  end

  defp step(_octopi, 0, total), do: total
  defp step(octopi, n, total) do
    {octopi, flashed} =
      octopi
      |> increase_all()
      |> flash()

    flashed
    |> Enum.reduce(octopi, fn k, m -> Map.put(m, k, 0) end)
    |> step(n - 1, total + Enum.count(flashed))
  end

  defp increase_all(octopi) do
    octopi
    |> Enum.map(fn {k, v} -> {k, v + 1} end)
    |> Enum.into(%{})
  end

  defp flash(octopi) do
    to_flash = octopi
    |> Enum.filter(fn {_k, v} -> v == 10 end)
    |> Enum.map(fn {k, _v} -> k end)

    do_flash(octopi, to_flash, [])
  end

  defp do_flash(octopi, [], flashed), do: {octopi, flashed}
  defp do_flash(octopi, [pos | rest], flashed) do
    affected = pos |> neighbors() |> Enum.filter(fn k -> Map.has_key?(octopi, k) end)
    octopi = Enum.reduce(affected, octopi, fn p, o -> Map.update!(o, p, fn v -> v + 1 end) end)
    activated = affected |> Enum.filter(fn k -> Map.get(octopi, k) == 10 end)

    do_flash(octopi, activated ++ rest, [pos | flashed])
  end

  defp neighbors({x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x, y},
      {x + 1, y},
      {x - 1, y+1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
  end

  defp parse(input) do
    11
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.with_index()
    |> Stream.flat_map(fn {line, y} ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {v, x} -> {{x, y}, v} end)
    end)
    |> Enum.into(%{})
  end
end
