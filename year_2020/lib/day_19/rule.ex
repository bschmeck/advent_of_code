defmodule Day19.Rule do
  def build(char) when is_binary(char) do
    fn {:ok, s} -> call(s, char)
      s -> call(s, char)
    end
  end
  def build(rules) when is_list(rules) do
    fn s ->
      case hd(rules).(s) do
        {:ok, ""} -> true
        {:ok, s} -> hd(tl(rules)).(s)
        _ -> false
      end
    end
  end

  defp call(char, char), do: true
  defp call(str, char) do
    case String.starts_with?(str, char) do
      true -> {:ok, String.replace_prefix(str, char, "")}
      false -> false
    end
  end
end
