defmodule Day04 do
  def part_one do
    InputFile.contents_of(4, :stream)
    |> Enum.chunk_while("", &accum/2, &finish/1)
    |> Enum.map(&String.split/1)
    |> Enum.count(&valid?/1)
  end

  defp accum("\n", str), do: {:cont, str, ""}
  defp accum(line, str), do: {:cont, "#{str}#{line}"}

  defp finish(str), do: {:cont, str, ""}

  defp valid?(parts) do
    set = parts
    |> Enum.map(&(String.split(&1, ":") |> hd))
    |> Enum.into(MapSet.new())

    ~w[byr iyr eyr hgt hcl ecl pid]
    |> Enum.all?(&(MapSet.member?(set, &1)))
  end
end
