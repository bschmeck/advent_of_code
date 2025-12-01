defmodule Day01 do
  defmodule Dial do
    defstruct pos: 50, count: 0

    def rotate(clicks, %Dial{pos: pos, count: count}), do: update(pos + clicks, count)
    def update(new_pos, count) when rem(new_pos, 100) == 0, do: %Dial{pos: 0, count: count + 1}
    def update(new_pos, count), do: %Dial{pos: rem(new_pos, 100), count: count}

    def rotate2(clicks, %Dial{pos: pos, count: count}) when clicks < -100 or clicks > 100 do
      rotate2(rem(clicks, 100), %Dial{pos: pos, count: count + abs(div(clicks, 100))})
    end
    def rotate2(clicks, %Dial{pos: pos}=dial), do: update2(dial, pos + clicks)
    def update2(%Dial{}=dial, new_pos) when new_pos > 0 and new_pos < 100, do: %Dial{dial | pos: new_pos}
    def update2(%Dial{}=dial, new_pos) when new_pos == 0 or new_pos == 100, do: %Dial{pos: 0, count: dial.count + 1}
    def update2(%Dial{pos: pos}=dial, new_pos) when pos > 0 and new_pos < 0, do: %Dial{pos: new_pos + 100, count: dial.count + 1}
    def update2(%Dial{}=dial, new_pos) when new_pos < 0, do: %Dial{pos: new_pos + 100, count: dial.count}
    def update2(%Dial{}=dial, new_pos) when new_pos > 100, do: %Dial{pos: new_pos - 100, count: dial.count + 1}

  end

  def part_one(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(&parse_rotation/1)
    |> Enum.reduce(%Dial{}, &Dial.rotate/2)
    |> Map.get(:count)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(1, :stream)
    |> Enum.map(&parse_rotation/1)
    |> Enum.reduce(%Dial{}, &Dial.rotate2/2)
    |> Map.get(:count)
  end

  defp parse_rotation("L" <> clicks), do: -String.to_integer(clicks)
  defp parse_rotation("R" <> clicks), do: String.to_integer(clicks)
end
