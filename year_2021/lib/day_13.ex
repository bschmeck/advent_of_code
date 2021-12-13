defmodule Day13 do
  defmodule Dot do
    defstruct [:x, :y]

    def new(x, y), do: %__MODULE__{x: x, y: y}

    def mirror(dot, :y, y), do: %__MODULE__{dot | y: 2 * y - dot.y}
    def mirror(dot, :x, x), do: %__MODULE__{dot | x: 2 * x - dot.x}
  end

  def part_one(input) do
    {dots, folds} = parse(input)

    dots
    |> fold(hd(folds))
    |> Enum.count()
  end

  def part_two(input) do
    {dots, folds} = parse(input)

    folds
    |> Enum.reduce(dots, fn fold, dots -> fold(dots, fold) end)
    |> print()
  end

  defp parse(input) do
    manual = input.contents_of(13)

    [dot_lines, fold_lines] = String.split(manual, "\n\n")

    dots =
      dot_lines
      |> String.split()
      |> Enum.map(fn l -> l |> String.split(",") |> Enum.map(&String.to_integer/1) end)
      |> Enum.map(fn [x, y] -> Dot.new(x, y) end)
      |> Enum.into(MapSet.new())

    folds =
      fold_lines
      |> String.split("\n", trim: true)
      |> Enum.map(&String.replace_prefix(&1, "fold along ", ""))
      |> Enum.map(&String.split(&1, "="))
      |> Enum.map(fn [axis, amt] -> {axis, String.to_integer(amt)} end)

    {dots, folds}
  end

  defp fold(dots, {"y", y}) do
    dots
    |> Enum.filter(fn dot -> dot.y > y end)
    |> Enum.reduce(dots, fn dot, dots ->
      dots
      |> MapSet.delete(dot)
      |> MapSet.put(Dot.mirror(dot, :y, y))
    end)
  end

  defp fold(dots, {"x", x}) do
    dots
    |> Enum.filter(fn dot -> dot.x > x end)
    |> Enum.reduce(dots, fn dot, dots ->
      dots
      |> MapSet.delete(dot)
      |> MapSet.put(Dot.mirror(dot, :x, x))
    end)
  end

  defp print(dots) do
    width = dots |> Enum.map(& &1.x) |> Enum.max()
    height = dots |> Enum.map(& &1.y) |> Enum.max()

    for y <- 0..height do
      for x <- 0..width do
        if MapSet.member?(dots, Dot.new(x, y)) do
          "#"
        else
          "."
        end
      end
      |> Enum.join()
      |> IO.puts()
    end
  end
end
