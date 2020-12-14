defmodule Day13 do
  def part_one(file_reader \\ InputFile) do
    [timestamp, shuttles, ""] =
      file_reader.contents_of(13)
      |> String.split("\n")

    timestamp = String.to_integer(timestamp)

    shuttles
    |> String.split(",")
    |> Enum.reject(&(&1 == "x"))
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(fn id -> [id, time_to_shuttle(timestamp, id)] end)
    |> Enum.min_by(fn [_, v] -> v end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(file_reader \\ InputFile) do
    [_timestamp, shuttles, ""] =
      file_reader.contents_of(13)
      |> String.split("\n")

    shuttles
    |> String.split(",")
    |> Enum.map(fn
      "x" -> -1
      c -> String.to_integer(c)
    end)
    |> Enum.with_index()
    |> Enum.reject(fn {x, _i} -> x == -1 end)
    |> compute_arrival
  end

  def compute_arrival(shuttles) do
    big_m = shuttles |> Enum.map(fn {x, _i} -> x end) |> Enum.reduce(&Kernel.*/2)
    # The head will always be zeroed out, so we just drop it from the calc
    sum =
      shuttles
      |> tl
      |> Enum.map(fn {x, i} ->
        m = div(big_m, x)

        (x - i) * m * modular_inverse(rem(m, x), x)
      end)
      |> Enum.reduce(&Kernel.+/2)

    rem(sum, big_m)
  end

  def gcd(a, b) when a > b, do: gcd(a, b, [])
  def gcd(a, b), do: gcd(b, a)
  def gcd(_a, 0, divs), do: divs |> tl |> Enum.reverse()
  def gcd(0, _b, divs), do: divs |> tl |> Enum.reverse()
  def gcd(a, b, divs), do: gcd(b, rem(a, b), [div(a, b) | divs])

  def modular_inverse(a, b) do
    gcd(a, b) |> iter(0, 1, b)
  end

  def iter(qs, p_0, p_1, b) when p_1 < 0, do: iter(qs, p_0, b + p_1, b)
  def iter([], _, p_1, _), do: p_1

  def iter([q | rest], p_0, p_1, b) do
    p_2 = rem(p_0 - p_1 * q, b)
    iter(rest, p_1, p_2, b)
  end

  defp time_to_shuttle(timestamp, t) when rem(timestamp, t) == 0, do: 0
  defp time_to_shuttle(timestamp, t), do: t - rem(timestamp, t)
end
