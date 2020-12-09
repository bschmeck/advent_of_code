defmodule Day07.Contents do
  defstruct [:color, :number]

  def parse(raw) do
    parsed =
      ~r/(?<number>\d+) (?<color>.*) bags?$/
      |> Regex.named_captures(String.trim(raw))

    %__MODULE__{
      color: Map.get(parsed, "color"),
      number: parsed |> Map.get("number") |> String.to_integer()
    }
  end
end
