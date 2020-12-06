defmodule Day06 do
  def part_one do
    InputFile.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_while("", &accum/2, &finish/1)
    |> Enum.map(fn str -> String.split(str, "", trim: true) end)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(fn a, b -> a + b end)
  end

  defp accum("", str), do: {:cont, str, ""}
  defp accum(line, str), do: {:cont, "#{str}#{line}"}

  defp finish(str), do: {:cont, str, ""}
end
