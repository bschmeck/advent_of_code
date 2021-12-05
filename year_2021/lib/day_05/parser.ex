defmodule Day05.Parser do
  import NimbleParsec

  point =
    integer(min: 1)
    |> ignore(string(","))
    |> integer(min: 1)

  defparsec(:line, point |> ignore(string(" -> ")) |> concat(point))
end
