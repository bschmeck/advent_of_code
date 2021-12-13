defmodule Day10 do
  def part_one(input) do
    10
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line/1)
    |> Stream.filter(fn
      {:corrupted, _} -> true
      _ -> false
    end)
    |> Stream.map(fn {_, char} -> char end)
    |> Stream.map(&corrupted_score/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input) do
    10
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line/1)
    |> Stream.filter(fn
      {:incomplete, _} -> true
      _ -> false
    end)
    |> Stream.map(fn {_, remaining} -> remaining end)
    |> Stream.map(&autocomplete_score/1)
    |> Enum.sort()
    |> middle()
  end

  def parse_line(str), do: do_parse_line(str, [])

  defp do_parse_line(<<head, rest::binary>>, [head | stack]), do: do_parse_line(rest, stack)
  defp do_parse_line(<<?(, rest::binary>>, stack), do: do_parse_line(rest, [?) | stack])
  defp do_parse_line(<<?[, rest::binary>>, stack), do: do_parse_line(rest, [?] | stack])
  defp do_parse_line(<<?{, rest::binary>>, stack), do: do_parse_line(rest, [?} | stack])
  defp do_parse_line(<<?<, rest::binary>>, stack), do: do_parse_line(rest, [?> | stack])
  defp do_parse_line("", stack), do: {:incomplete, stack}
  defp do_parse_line(<<c, _rest::binary>>, _stack), do: {:corrupted, c}

  defp corrupted_score(?)), do: 3
  defp corrupted_score(?]), do: 57
  defp corrupted_score(?}), do: 1197
  defp corrupted_score(?>), do: 25137

  defp autocomplete_score(remaining), do: autocomplete_score(remaining, 0)
  defp autocomplete_score([], total), do: total

  defp autocomplete_score([char | rest], total),
    do: autocomplete_score(rest, total * 5 + autocomplete_char_score(char))

  defp autocomplete_char_score(?)), do: 1
  defp autocomplete_char_score(?]), do: 2
  defp autocomplete_char_score(?}), do: 3
  defp autocomplete_char_score(?>), do: 4

  defp middle(l) do
    midpoint = div(Enum.count(l) - 1, 2)
    Enum.at(l, midpoint)
  end
end
