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

  def part_two(file_reader \\ InputFile) do
    [fields, our_ticket, other_tickets] =
      file_reader.contents_of(16, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.chunk_while([], &accum/2, &finish/1)

    fields = Enum.map(fields, &Day16.Field.parse/1)

    ticket_values = our_ticket |> hd |> String.split(",") |> Enum.map(&String.to_integer/1)

    other_tickets
    |> Enum.reverse()
    |> tl
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn arr -> Enum.map(arr, &String.to_integer/1) end)
    |> Enum.filter(fn values ->
      Enum.all?(values, fn value ->
        Enum.any?(fields, fn field -> Day16.Field.valid_value?(field, value) end)
      end)
    end)
    |> Enum.map(fn ticket ->
      Enum.map(ticket, fn n ->
        fields
        |> Enum.filter(&Day16.Field.valid_value?(&1, n))
        |> Enum.map(& &1.name)
        |> Enum.into(MapSet.new())
      end)
    end)
    |> Enum.reduce(&combine_sets/2)
    |> simplify
    |> Enum.zip(ticket_values)
    |> Enum.filter(fn {name, _value} -> String.starts_with?(name, "departure") end)
    |> Enum.map(fn {_name, value} -> value end)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp combine_sets(a, b), do: combine_sets(a, b, [])
  defp combine_sets([], [], sets), do: Enum.reverse(sets)

  defp combine_sets([a | rest_a], [b | rest_b], sets),
    do: combine_sets(rest_a, rest_b, [MapSet.intersection(a, b) | sets])

  defp simplify(sets) do
    case Enum.all?(sets, fn set -> MapSet.size(set) == 1 end) do
      true ->
        Enum.flat_map(sets, &MapSet.to_list/1)

      false ->
        simplify(
          sets,
          sets |> Enum.filter(&(MapSet.size(&1) == 1)) |> Enum.reduce(&MapSet.union/2)
        )
    end
  end

  defp simplify(sets, chosen) do
    sets
    |> Enum.map(fn set ->
      case MapSet.size(set) do
        1 -> set
        _ -> MapSet.difference(set, chosen)
      end
    end)
    |> simplify
  end

  defp accum("", lines), do: {:cont, lines, []}

  defp accum(line, lines) do
    {:cont, [line | lines]}
  end

  defp finish(line), do: {:cont, line, []}
end
