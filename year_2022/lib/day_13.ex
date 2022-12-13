defmodule Day13 do
  def part_one(input \\ InputFile) do
    input.contents_of(13, :stream)
    |> Enum.map(fn line -> Code.eval_string(line) |> elem(0) end)
    |> Enum.reject(fn line -> line == nil end)
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.filter(fn {[left, right], _index} -> valid?(left, right) end)
    |> Enum.map(fn {_pair, index} -> index end)
    |> Enum.sum()
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
  def valid?([], [_ | _]), do: true
  def valid?([_ | _], []), do: false
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
