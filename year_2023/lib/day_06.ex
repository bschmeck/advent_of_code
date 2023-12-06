defmodule Day06 do
  def part_one(input \\ InputFile) do
    input.contents_of(6, :stream)
    |> Enum.map(fn line -> String.split(line, ":") |> tl() |> hd() end)
    |> Enum.map(fn numbers -> String.split(numbers, " ", trim: true) end)
    |> Enum.map(fn numbers -> Enum.map(numbers, &String.to_integer/1) end)
    |> Enum.zip()
    |> Enum.map(fn {time, record} -> count_ways(time, record) end)
    |> Enum.reduce(fn a, b -> a * b end)
  end

  def part_two(input \\ InputFile) do
    [time, record] = input.contents_of(6, :stream)
    |> Enum.map(fn line -> String.split(line, ":") |> tl() |> hd() end)
    |> Enum.map(fn numbers -> String.split(numbers, " ", trim: true) end)
    |> Enum.map(fn numbers -> Enum.join(numbers) |> String.to_integer() end)

    count_ways(time, record)
  end

  def count_ways(time, record) do
    sqrt = :math.sqrt(time * time - 4 * record)

    min = next((-time + sqrt) * -0.5)
    max = prev((-time - sqrt) * -0.5)

    max - min + 1
  end

  def next(float) do
    Float.floor(float + 1) |> Kernel.round()
  end

  def prev(float) do
    Float.ceil(float - 1) |> Kernel.round()
  end
end
