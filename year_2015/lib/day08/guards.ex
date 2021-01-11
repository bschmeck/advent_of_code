defmodule Day08.Guards do
  defguard is_hex(a) when a == "0" or a == "1" or a == "2" or a == "3" or a == "4" or a == "5" or a == "6" or a == "7" or a == "8" or a == "9" or a == "a" or a == "b" or a == "c" or a == "d" or a == "e" or a == "f"
end
