defmodule Day16 do
  def part_one(file_reader \\ InputFile) do
    [fields, _our_ticket, other_tickets] =
      file_reader.contents_of(16, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_while([], &accum/2, &finish/1)

    fields = Enum.map(fields, &Day16.Field.parse/1)

    other_tickets
    |> Enum.reverse()
    |> tl
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn arr -> Enum.map(arr, &String.to_integer/1) end)
    |> Enum.flat_map(fn values ->
      Enum.reject(values, fn value ->
        Enum.any?(fields, &Day16.Field.valid_value?(&1, value))
      end)
    end)
    |> Enum.reduce(&Kernel.+/2)
  end

  defp accum("", lines), do: {:cont, lines, []}

  defp accum(line, lines) do
    {:cont, [line | lines]}
  end

  defp finish(line), do: {:cont, line, []}
end
