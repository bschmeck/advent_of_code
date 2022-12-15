defmodule Mix.Tasks.Day do
  @shortdoc "Executes the solution for a given day"

  use Mix.Task

  @impl Mix.Task
  def run(["10.2"]), do: Day10.part_two(InputFile) |> IO.puts
  def run(["15.1"]), do: Day15.part_one(InputFile, 2_000_000) |> IO.puts

  def run([arg]) do
    with [day, part] <- String.split(arg, "."),
         {:ok, module} <- module_for(day)
    do
      case part do
        "1" -> module.part_one(InputFile) |> IO.inspect()
        "2" -> module.part_two(InputFile) |> IO.inspect()
        _ -> Mix.raise("Unsupported part #{part}")
      end
    else
      {:error, msg} -> Mix.raise(msg)
    _ -> Mix.raise("Unkown failure.")
    end
  end

  defp module_for(day) do
    try do
      padded = String.pad_leading(day, 2, "0")
      {:ok, Module.safe_concat(["Day#{padded}"])}
    rescue
      ArgumentError -> {:error, "Day #{day} has not been implemented."}
    end
  end
end
