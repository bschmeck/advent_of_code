defmodule Mix.Tasks.Fetch do
  use Mix.Task

  @shortdoc "Fetch the input and test files for AoC days"
  def run(_) do
    published_days()
    |> Enum.reject(&exists?/1)
    |> Enum.each(&prep_day/1)
  end

  defp published_days() do
    case east_coast_date() do
      %Date{year: 2022, month: 12, day: d} when d <= 25 -> Enum.to_list(1..d)
      %Date{year: 2022, month: 12, day: d} when d > 25 -> Enum.to_list(1..25)
      %Date{year: 2023} -> Enum.to_list(1..25)
      _ -> []
    end
  end

  defp east_coast_date() do
    DateTime.now!("Etc/UTC")
    |> DateTime.add(-5 * 60 * 60, :second)
    |> DateTime.to_date()
  end

  defp exists?(day), do: InputFile.filename_for(day) |> File.exists?()

  defp prep_day(day) do
    fetch_input(day)
    touch_test_input(day)
    create_module(day)
    create_test_file(day)
  end

  defp fetch_input(day) do
    url = "https://adventofcode.com/2022/day/#{day}/input"
    {:ok, response} = Tesla.get(url, headers: [{"cookie", cookie()}])
    day |> InputFile.filename_for() |> File.write(response.body)
  end

  defp touch_test_input(day), do: day |> InputTestFile.filename_for() |> File.touch()

  defp create_module(day) do
    source = Path.join(:code.priv_dir(:year_2022), "day_module.eex")
    day = day |> Integer.to_string() |> String.pad_leading(2, "0")
    contents = EEx.eval_file(source, day: day)
    location = Path.join([:code.priv_dir(:year_2022), "..", "lib", "day_#{day}.ex"])
    File.write(location, contents)
  end

  defp create_test_file(day) do
    source = Path.join(:code.priv_dir(:year_2022), "day_module_test.eex")
    day = day |> Integer.to_string() |> String.pad_leading(2, "0")
    contents = EEx.eval_file(source, day: day)
    location = Path.join([:code.priv_dir(:year_2022), "..", "test", "day_#{day}_test.exs"])
    File.write(location, contents)
  end

  defp cookie, do: "session=#{Application.fetch_env!(:year_2022, :session)}"
end
