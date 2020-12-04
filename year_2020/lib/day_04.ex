defmodule Day04 do
  def part_one do
    passports() |> Enum.count(&valid_fields?/1)
  end

  def part_two do
    passports() |> Enum.count(&valid?/1)
  end

  defp accum("\n", str), do: {:cont, str, ""}
  defp accum(line, str), do: {:cont, "#{str}#{line}"}

  defp finish(str), do: {:cont, str, ""}

  defp passports() do
    InputFile.contents_of(4, :stream)
    |> Enum.chunk_while("", &accum/2, &finish/1)
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_passport/1)
  end

  defp parse_passport(parts) do
    parts
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.reduce(%{}, fn [k, v], map -> Map.put(map, k, v) end)
  end

  defp valid?(passport) do
    valid_fields?(passport) && valid_contents?(passport)
  end

  defp valid_fields?(passport) do
    ~w[byr iyr eyr hgt hcl ecl pid]
    |> Enum.all?(&Map.has_key?(passport, &1))
  end

  defp valid_contents?(passport) do
    passport
    |> Enum.all?(&valid_contents_for_field?/1)
  end

  defp valid_contents_for_field?({"byr", n}), do: number_between?(n, 1920, 2002)
  defp valid_contents_for_field?({"iyr", n}), do: number_between?(n, 2010, 2020)
  defp valid_contents_for_field?({"eyr", n}), do: number_between?(n, 2020, 2030)

  defp valid_contents_for_field?({"hgt", <<n::binary-size(2), "in">>}),
    do: number_between?(n, 59, 76)

  defp valid_contents_for_field?({"hgt", <<n::binary-size(3), "cm">>}),
    do: number_between?(n, 150, 193)

  defp valid_contents_for_field?({"hcl", c}), do: c =~ ~r/^#[0-9-a-f]{6}$/
  defp valid_contents_for_field?({"ecl", "amb"}), do: true
  defp valid_contents_for_field?({"ecl", "blu"}), do: true
  defp valid_contents_for_field?({"ecl", "brn"}), do: true
  defp valid_contents_for_field?({"ecl", "gry"}), do: true
  defp valid_contents_for_field?({"ecl", "grn"}), do: true
  defp valid_contents_for_field?({"ecl", "hzl"}), do: true
  defp valid_contents_for_field?({"ecl", "oth"}), do: true
  defp valid_contents_for_field?({"pid", n}), do: n =~ ~r/^\d{9}$/
  defp valid_contents_for_field?({"cid", _}), do: true
  defp valid_contents_for_field?(_), do: false

  defp number_between?(n, low, high) when is_binary(n),
    do: number_between?(String.to_integer(n), low, high)

  defp number_between?(n, low, high) when n >= low and n <= high, do: true
  defp number_between?(_, _, _), do: false
end
