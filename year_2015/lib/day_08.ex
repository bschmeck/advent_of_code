defmodule Day08 do
  import Day08.Guards

  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(8, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&count_escapes/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(8, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&count_reescaped/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def count_escapes(str), do: String.length(str) - String.length(unescape(str))

  def count_reescaped(str), do: 2 + String.length(escape(str)) - String.length(str)

  def unescape(<<"\"", rest::binary>>), do: unescape(rest, [])
  def unescape("\"", lst), do: lst |> Enum.reverse() |> Enum.join()
  def unescape(<<"\\\\", rest::binary>>, lst), do: unescape(rest, ["\\" | lst])
  def unescape(<<"\\\"", rest::binary>>, lst), do: unescape(rest, ["\"" | lst])
  def unescape(<<"\\x", a::binary-size(1), b::binary-size(1), rest::binary>>, lst) when is_hex(a) and is_hex(b), do: unescape(rest, ["X" | lst])
  def unescape(<<c::binary-size(1), rest::binary>>, lst), do: unescape(rest, [c | lst])

  def escape(str), do: escape(str, [])
  def escape("", lst), do: lst |> Enum.reverse() |> Enum.join()
  def escape(<<"\"", rest::binary>>, lst), do: escape(rest, ["\\" | ["\"" | lst]])
  def escape(<<"\\", rest::binary>>, lst), do: escape(rest, ["\\" | ["\\" | lst]])
  def escape(<<c::binary-size(1), rest::binary>>, lst), do: escape(rest, [c | lst])
end
