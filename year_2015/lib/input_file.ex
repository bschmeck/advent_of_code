defmodule InputFile do
  def filename_for(n) do
    day = n |> Integer.to_string() |> String.pad_leading(2, "0")
    Path.join(:code.priv_dir(:year_2015), "day_#{day}.txt")
  end

  def contents_of(n, mode \\ :read)

  def contents_of(n, :stream) do
    filename_for(n)
    |> File.stream!([], :line)
  end

  def contents_of(n, :read) do
    {:ok, raw} = filename_for(n) |> File.read()
    raw
  end
end
