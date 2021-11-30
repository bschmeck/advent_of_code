defmodule Mix.Tasks.Fetch do
  use Mix.Task

  @shortdoc "Fetch the input and test files for AoC days"
  def run(_) do
    published_days()
    |> Enum.flat_map(&([{&1, :input}, {&1, :test}]))
    |> Enum.reject(&(exists?(&1)))
    |> Enum.each(&(fetch(&1)))
  end

  defp published_days() do
    case east_coast_date() do
      %Date{year: 2021, month: 12, day: d} when d <= 25 -> Enum.to_list(1..d)
      %Date{year: 2021, month: 12, day: d} when d > 25 -> Enum.to_list(1..25)
      %Date{year: 2022} -> Enum.to_list(1..25)
      _ -> []
    end
  end

  defp east_coast_date() do
    DateTime.now!("Etc/UTC")
    |> DateTime.add(-5 * 60 * 60, :second)
    |> DateTime.to_date()
  end

  defp exists?({day, :input}), do: InputFile.filename_for(day) |> File.exists?
  defp exists?({day, :test}), do: InputTestFile.filename_for(day) |> File.exists?

  defp fetch({day, :input}) do
    url = "https://adventofcode.com/2021/day/#{day}/input"
    {:ok, response} = Tesla.get(url, headers: [{"cookie", cookie()}])
    day |> InputFile.filename_for() |> File.write(response.body)
  end
  defp fetch({day, :test}), do: day |> InputTestFile.filename_for() |> File.touch()

  defp cookie, do: "session=#{Application.fetch_env!(:aoc_api, :session)}"
end
