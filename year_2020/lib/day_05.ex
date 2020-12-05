defmodule Day05 do
  def part_one do
    seat_ids() |> Enum.max
  end

  def seat_ids do
    InputFile.contents_of(5, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&seat_id/1)
  end

  def seat_id(<<rows :: binary-size(7), cols :: binary-size(3)>>) do
    row_number(rows) * 8 + column_number(cols)
  end

  def row_number(rows), do: bisect(rows, 0, 127)
  def column_number(cols), do: bisect(cols, 0, 7)

  defp bisect("", n, n), do: n
  defp bisect(<<"F", rest :: binary>>, low, high), do: bisect(rest, low, round(:math.floor((high - low) / 2) + low))
  defp bisect(<<"L", rest :: binary>>, low, high), do: bisect(rest, low, round(:math.floor((high - low) / 2) + low))
  defp bisect(<<"B", rest :: binary>>, low, high), do: bisect(rest, round(:math.ceil((high - low) / 2) + low), high)
  defp bisect(<<"R", rest :: binary>>, low, high), do: bisect(rest, round(:math.ceil((high - low) / 2) + low), high)
end
