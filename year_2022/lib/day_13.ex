defmodule Day13 do
  def part_one(input \\ InputFile) do

  end

  def part_two(_input \\ InputFile) do

  end

  def valid?(left, right) when is_integer(left) and is_integer(right) do
    case left - right do
                0 -> :cont
                i when i < 0 -> true
                _ -> false
    end
  end
  def valid?([left | _], [right | _]) when is_integer(left) and is_integer(right) and left > right, do: false
  def valid?([], [_]), do: true
  def valid?([_], []), do: false
  def valid?([], []), do: :cont
  def valid?([left | rest], [right | rest2]) when is_integer(left) and is_list(right), do: valid?([[left] | rest], [right | rest2])
  def valid?([left | rest], [right | rest2]) when is_list(left) and is_integer(right), do: valid?([left | rest], [[right] | rest2])
  def valid?(left, right) do
    case valid?(hd(left), hd(right)) do
      :cont -> valid?(tl(left), tl(right))
      res -> res
    end
  end
end
