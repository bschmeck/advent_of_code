defmodule Day03.Forest do
  def tree?(row, n) do
    case row do
      <<_header::binary-size(n), "#", _rest::binary>> -> true
      _ -> false
    end
  end
end
