defmodule Day15 do
  alias Day15.Route

  def part_one(input) do
    grid =
      15
      |> input.contents_of(:stream)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Stream.flat_map(fn {line, y} ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.map(fn {risk, x} -> {{x, y}, risk} end)
      end)
      |> Enum.into(%{})

    goal_x = grid |> Map.keys() |> Enum.map(fn {x, _y} -> x end) |> Enum.max()
    goal_y = grid |> Map.keys() |> Enum.map(fn {_x, y} -> y end) |> Enum.max()
    goal = {goal_x, goal_y}

    route = safest(grid, goal, [Route.new(goal)])

    route.total_risk
  end

  defp safest(_grid, goal, [%Route{current_node: goal} = route | rest]) do
    # IO.inspect(rest)
    # nodes = Enum.map(rest, &(&1.current_node))
    # IO.puts "#{inspect Enum.count(rest)} other routes and #{nodes |> Enum.uniq |> Enum.count} unique locations"
    # dupes = Enum.frequencies(nodes) |> Enum.filter(fn {k, v} -> v > 1 end) |> Enum.map(fn {k, v} -> k end) |> Enum.take(5) |> Enum.into(MapSet.new())
    # IO.inspect Enum.filter(rest, fn r -> MapSet.member?(dupes, r.current_node) end)
    route
  end

  defp safest(grid, goal, [route | rest]) do
    # IO.inspect(routes)
    # IO.puts("#{inspect(route.current_node)} #{route.total_risk} #{Enum.count(rest)}")

    routes =
      [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
      |> Enum.map(fn {x_adj, y_adj} ->
        {elem(route.current_node, 0) + x_adj, elem(route.current_node, 1) + y_adj}
      end)
      |> Enum.filter(fn pos -> Map.has_key?(grid, pos) end)
      |> Enum.reject(fn pos -> Route.visited?(route, pos) end)
      |> Enum.map(fn pos -> Route.move(route, pos, Map.fetch!(grid, pos), goal) end)
      |> Enum.sort_by(& &1.estimate)
      # |> IO.inspect
      |> insert(rest, [])

    # IO.puts "===================="
    safest(grid, goal, routes)
  end

  defp insert([], existing, routes), do: Enum.reverse(routes) ++ existing
  defp insert(steps, [], routes), do: Enum.reverse(routes) ++ steps

  defp insert(
         [%Route{current_node: pos} | steps],
         [%Route{current_node: pos} = existing | rest],
         routes
       ) do
    # We have a cheaper route to pos, drop the new step
    insert(steps, rest, [existing | routes])
  end

  defp insert(
         [%Route{estimate: risk} = step | steps],
         [%Route{estimate: risk2} | _rest] = existing,
         routes
       )
       when risk <= risk2 do
    insert(
      steps,
      # |> IO.inspect,
      Enum.reject(existing, fn r -> r.current_node == step.current_node end),
      [step | routes]
    )
  end

  defp insert(steps, [existing | rest], routes) do
    # IO.puts "Route with #{existing.estimate} is cheaper."
    insert(steps, rest, [existing | routes])
  end
end
