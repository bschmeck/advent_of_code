defmodule Day01 do
  defmodule Dial do
    defstruct pos: 50, count: 0

    def rotate(clicks, %Dial{pos: pos, count: count}), do: update(pos + clicks, count)
    def update(new_pos, count) when rem(new_pos, 100) == 0, do: %Dial{pos: 0, count: count + 1}
    def update(new_pos, count), do: %Dial{pos: rem(new_pos, 100), count: count}
  end

  def part_one(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(&parse_rotation/1)
    |> Enum.reduce(%Dial{}, &Dial.rotate/2)
    |> Map.get(:count)
  end

  def part_two(_input \\ InputFile) do

  end

  defp parse_rotation("L" <> clicks), do: -String.to_integer(clicks)
  defp parse_rotation("R" <> clicks), do: String.to_integer(clicks)
end
