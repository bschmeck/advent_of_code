defmodule Day19.Rule do
  def build(char) when is_binary(char) do
    fn s ->
      cond do
        s == char -> true
        String.starts_with?(s, char) -> String.replace_prefix(s, char, "")
        true -> false
      end
    end
  end

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
end
