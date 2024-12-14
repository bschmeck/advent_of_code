defmodule Day14 do
  def part_one(input \\ InputFile, width \\ 101, height \\ 103) do
    input.contents_of(14, :stream)
    |> Enum.map(&parse/1)
    |> Enum.map(&move(&1, width, height))
    |> Enum.sort()
    |> group(div(width, 2), div(height, 2), 0, 0, 0, 0)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def parse(row) do
    [_match, x, y, dx, dy] = Regex.run(~r{p=(\d+),(\d+) v=(-?\d+),(-?\d+)}, row)

    [{String.to_integer(x), String.to_integer(y)}, {String.to_integer(dx), String.to_integer(dy)}]
  end

  def move([{x, y}, {dx, dy}], width, height) do
    {wrap(x + 100 * dx, width), wrap(y + 100 * dy, height)}
  end

  def wrap(a, b) do
    case rem(a, b) do
      x when x < 0 -> b - abs(x)
      x -> x
    end
  end

  def group([], _mid_x, _mid_y, ul, ur, ll, lr), do: [ul, ur, ll, lr]
  def group([{x, y} | rest], mid_x, mid_y, ul, ur, ll, lr) when x < mid_x and y < mid_y, do: group(rest, mid_x, mid_y, ul + 1, ur, ll, lr)
  def group([{x, y} | rest], mid_x, mid_y, ul, ur, ll, lr) when x > mid_x and y < mid_y, do: group(rest, mid_x, mid_y, ul, ur + 1, ll, lr)
  def group([{x, y} | rest], mid_x, mid_y, ul, ur, ll, lr) when x < mid_x and y > mid_y, do: group(rest, mid_x, mid_y, ul, ur, ll + 1, lr)
  def group([{x, y} | rest], mid_x, mid_y, ul, ur, ll, lr) when x > mid_x and y > mid_y, do: group(rest, mid_x, mid_y, ul, ur, ll, lr + 1)
  def group([{_x, _y} | rest], mid_x, mid_y, ul, ur, ll, lr), do: group(rest, mid_x, mid_y, ul, ur, ll, lr)
end
