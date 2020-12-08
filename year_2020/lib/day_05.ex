defmodule Day05 do
  use Bitwise

  def part_one do
    seat_ids() |> Enum.max
  end

  def part_two do
    seat_ids()
    |> Enum.sort
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.reject(fn [a, b,c] -> a + 1 == b && c - 1 == b end)
  end

  def seat_ids do
    InputFile.contents_of(5, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&seat_id/1)
  end

  def seat_id(str), do: seat_id(str, 0)
  def seat_id("", n), do: n
  def seat_id(<<"F", rest :: binary>>, n), do: seat_id(rest, n <<< 1)
  def seat_id(<<"B", rest :: binary>>, n), do: seat_id(rest, n <<< 1 ||| 1)
  def seat_id(<<"L", rest :: binary>>, n), do: seat_id(rest, n <<< 1)
  def seat_id(<<"R", rest :: binary>>, n), do: seat_id(rest, n <<< 1 ||| 1)
end
