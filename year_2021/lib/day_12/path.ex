defmodule Day12.Path do
  defstruct [:cave, :visited]

  def new, do: %__MODULE__{cave: "start", visited: MapSet.new()}

  def visit(path, cave) do
    if small?(cave) do
      %__MODULE__{cave: cave, visited: MapSet.put(path.visited, cave)}
    else
      %__MODULE__{path | cave: cave}
    end
  end

  def can_visit?(path, cave), do: !MapSet.member?(path.visited, cave)
  def complete?(path), do: path.cave == "end"

  defp small?(cave), do: String.downcase(cave) == cave
end
