defmodule Day16.Field do
  defstruct [:name, :ranges]

  def valid_value?(%__MODULE__{ranges: ranges}, value) do
    Enum.any?(ranges, &Enum.member?(&1, value))
  end

  def parse(line) do
    [name, ranges] = String.split(line, ":") |> Enum.map(&String.trim/1)

    ranges =
      ranges
      |> String.split(" or ")
      |> Enum.map(fn range -> String.split(range, "-") end)
      |> Enum.map(fn [lo, hi] ->
        %Range{first: String.to_integer(lo), last: String.to_integer(hi)}
      end)

    %__MODULE__{name: name, ranges: ranges}
  end
end
