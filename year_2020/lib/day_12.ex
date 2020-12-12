defmodule Day12 do
  def part_one(file_reader \\ InputFile), do: navigate(file_reader, Day12.Ship)
  def part_two(file_reader \\ InputFile), do: navigate(file_reader, Day12.WaypointShip)

  def navigate(file_reader, ship_type) do
    ship =
      file_reader.contents_of(12, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&parse/1)
      |> ship_type.follow_instructions()

    abs(ship.x) + abs(ship.y)
  end

  def parse(<<op::binary-size(1), rest::binary>>), do: {op, String.to_integer(rest)}
end
