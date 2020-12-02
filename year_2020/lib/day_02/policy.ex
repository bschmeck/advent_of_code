defmodule Day02.Policy do
  defstruct [:char, :max, :min]

  def valid?(%__MODULE__{} = policy, password) do
    count = password |> String.split("", trim: true) |> Enum.count(fn(c) -> c == policy.char end)

    count >= policy.min && count <= policy.max
  end

  def indexes_valid?(%__MODULE__{} = policy, password) do
    validate_at_indexes(String.at(password, policy.min - 1), String.at(password, policy.max - 1), policy.char)
  end

  defp validate_at_indexes(a, b, a) when a != b, do: true
  defp validate_at_indexes(a, b, b) when a != b, do: true
  defp validate_at_indexes(_, _, _), do: false
end
