defmodule Day20 do
  def part_one(input \\ 33100000) do
    detect(input, 1)
  end

  def part_two(input \\ 33100000) do
    detect2(input, 776160)
  end

  def detect(target, house) do
    case 10 * sum_of_factors(house) do
      x when x >= target -> house
      _ -> detect(target, house + 1)
    end
  end

  def detect2(target, house) do
    case 11 * sum_of_factors2(house) do
      x when x >= target -> house
      _ -> detect(target, house + 1)
    end
  end

  def sum_of_factors(n) do
    factors_of(n) |> Enum.concat() |> Enum.reduce(&Kernel.+/2)
  end

  def sum_of_factors2(n) do
    factors_of(n)
    |> Enum.map(&first_fifty/1)
    |> Enum.concat()
    |> Enum.reduce(&Kernel.+/2)
  end

  def factors_of(n) do
    1..floor(:math.sqrt(n))
    |> Enum.map(fn x ->
      case rem(n, x) do
        0 -> [x, div(n, x)]
        _ -> []
      end
    end)
  end

  def first_fifty([a, b]) when a <= 50 and b <= 50, do: [a, b]
  def first_fifty([a, b]) when a <= 50 and b > 50, do: [b]
  def first_fifty([a, b]) when a > 50 and b <= 50, do: [a]
  def first_fifty(_), do: []
end
