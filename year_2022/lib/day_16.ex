defmodule Day16 do
  def part_one(input \\ InputFile) do
    valves = input.contents_of(16, :stream)
    |> Enum.map(&parse_valve/1)
    |> Map.new()

    targets = valves
    |> Enum.filter(fn {name, {rate, _}} -> rate > 0 end)
    |> Enum.map(&elem(&1, 0))
    |> MapSet.new()
  end

  def part_two(_input \\ InputFile) do

  end

  defp parse_valve(line) do
    [_, name, rate, tunnels] = Regex.run(~r/^Valve (.*) has flow rate=(.*); tunnels? leads? to valves? (.*)$/, line)

    {name, {String.to_integer(rate), String.split(tunnels, ", ")}}
  end

  def total_pressure_released(flow_rate, minutes_remaining), do: flow_rate * minutes_remaining
end
