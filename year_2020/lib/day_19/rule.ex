defmodule Day19.Rule do
  def build(char) when is_binary(char), do: fn s -> call(s, char) end
  def build(rule_list) when is_list(rule_list) do
    fn s ->
      Stream.map(rule_list, fn rules ->
        Enum.reduce(rules, s, fn
          _, false -> false
          rule, s -> rule.(s)
        end)
      end)
      |> Stream.filter(fn
        false -> false
        _ -> true
      end)
      |> Enum.at(0, false)
    end
  end

  defp call(char, char), do: true
  defp call(str, char) do
    case String.starts_with?(str, char) do
      true -> String.replace_prefix(str, char, "")
      false -> false
    end
  end
end
