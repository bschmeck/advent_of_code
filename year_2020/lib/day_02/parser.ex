defmodule Day02.Parser do
  import NimbleParsec

  defparsec(
    :password_row,
    integer(min: 1)
    |> ignore(string("-"))
    |> integer(min: 1)
    |> ignore(string(" "))
    |> utf8_string([], 1)
    |> ignore(string(": "))
    |> utf8_string([], min: 1)
  )
end
