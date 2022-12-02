defmodule InputTestFile do
  def filename_for(n) do
    day = n |> Integer.to_string() |> String.pad_leading(2, "0")
    Path.join(:code.priv_dir(:year_2022), "test/day_#{day}.txt")
  end

  def contents_of(n, mode \\ :read)

  def contents_of(n, :stream) do
    filename_for(n)
    |> File.stream!([], :line)
    |> Enum.map(&String.trim_trailing(&1))
  end

  def contents_of(n, :read) do
    {:ok, raw} = filename_for(n) |> File.read()
    raw
  end
end
