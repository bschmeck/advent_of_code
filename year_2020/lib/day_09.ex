defmodule Day09 do
  def part_one(file_reader \\ InputFile, preamble_len \\ 25) do
    file_reader.contents_of(9, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.split(preamble_len)
    |> find_weakness()
  end

  defp find_weakness({stream, [n | rest]}) do
    set = Enum.into(stream, MapSet.new())

    stream
    |> Enum.any?(fn a -> MapSet.member?(set, n - a) && n != a * 2 end)
    |> case do
        true -> find_weakness({tl(stream) ++ [n], rest})
        _ -> n
    end
  end
end
