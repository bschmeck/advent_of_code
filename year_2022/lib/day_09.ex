defmodule Day09 do
  def part_one(input \\ InputFile) do
    simulate(input, 2)
  end

  def part_two(input \\ InputFile) do
    simulate(input, 10)
  end

  defp simulate(input, number_of_knots) do
    knots = for _ <- 1..number_of_knots, do: {0, 0}

    input.contents_of(9, :stream)
    |> Enum.map(fn l -> String.split(l, " ") end)
    |> Enum.map(fn [dir, amt] -> {dir, String.to_integer(amt)} end)
    |> move(knots, MapSet.new())
    |> MapSet.size()
  end

  defp move([], _knots, points), do: points
  defp move([{_dir, 0} | rest], knots, points), do: move(rest, knots, points)
  defp move(moves = [{"R", _amt} | _rest], [{x, y} | rope], points), do: do_move(moves, [{x + 1, y} | rope], points)
  defp move(moves = [{"L", _amt} | _rest], [{x, y} | rope], points), do: do_move(moves, [{x - 1, y} | rope], points)
  defp move(moves = [{"U", _amt} | _rest], [{x, y} | rope], points), do: do_move(moves, [{x, y + 1} | rope], points)
  defp move(moves = [{"D", _amt} | _rest], [{x, y} | rope], points), do: do_move(moves, [{x, y - 1} | rope], points)

  defp do_move([{dir, amt} | rest], rope, points) do
    {rope, tail} = adjust(rope)
    move([{dir, amt - 1} | rest], rope, MapSet.put(points, tail))
  end

  defp adjust(rope), do: adjust(rope, [])
  defp adjust([tail], adjusted), do: {Enum.reverse([tail | adjusted]), tail}
  defp adjust([h, t | rest], adjusted) do
    t = adjust_knots(h, t)
    adjust([t | rest], [h | adjusted])
  end

  def adjust_knots({h_x, h_y}, {t_x, t_y}) when abs(h_x - t_x) <= 1 and abs(h_y - t_y) <= 1, do: {t_x, t_y}
  def adjust_knots({h_x, h_y}, {t_x, t_y}) when abs(h_x - t_x) == 1, do: {h_x, div(h_y + t_y, 2)}
  def adjust_knots({h_x, h_y}, {t_x, t_y}) when abs(h_y - t_y) == 1, do: {div(h_x + t_x, 2), h_y}
  def adjust_knots({h_x, h_y}, {t_x, t_y}), do: {div(h_x + t_x, 2), div(h_y + t_y, 2)}
end
