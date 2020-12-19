defmodule Day19.Rule do
  def build(char) when is_binary(char) do
    fn {:ok, s} -> call(s, char)
      s -> call(s, char)
    end
  end
  def build(rules) when is_list(rules) do
    fn s ->
      Enum.reduce(rules, {:ok, s}, fn
        _, false -> false
        rule, {:ok, s} -> rule.(s)
      end)
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
