defmodule Day22.RangeParser do
  import NimbleParsec

  range =
    optional(string("-"))
    |> integer(min: 1)
    |> ignore(string(".."))
    |> optional(string("-"))
    |> integer(min: 1)

  defparsec(
    :ranges,
    ignore(string("x="))
    |> concat(range)
    |> ignore(string(",y="))
    |> concat(range)
    |> ignore(string(",z="))
    |> concat(range)
  )
end
