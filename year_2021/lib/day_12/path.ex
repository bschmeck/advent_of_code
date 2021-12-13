defmodule Day12.Path do
  defstruct [:cave, :visited]

  def new, do: %__MODULE__{cave: "start", visited: %{}}

  def visit(path, cave) do
    if small?(cave) do
      %__MODULE__{cave: cave, visited: Map.update(path.visited, cave, 1, &(&1 + 1))}
    else
      %__MODULE__{path | cave: cave}
    end
  end

  def can_visit?(path, cave, :part_one), do: !Map.has_key?(path.visited, cave)

  def can_visit?(path, cave, :part_two) do
    !Map.has_key?(path.visited, cave) || Map.values(path.visited) |> Enum.all?(&(&1 < 2))
  end

  def complete?(path), do: path.cave == "end"

  defp small?(cave), do: String.downcase(cave) == cave
end
