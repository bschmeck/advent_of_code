defmodule Day01.Fuel do
  def required_for(mass) do
    max(div(mass, 3) - 2, 0)
  end

  def total_for(mass), do: total_for(mass, 0)
  defp total_for(mass, fuel) do
    case required_for(mass) do
      0 -> fuel
      m -> total_for(m, fuel + m)
    end
  end
end

IO.puts "12: #{Day01.Fuel.required_for(12)}"
IO.puts "14: #{Day01.Fuel.required_for(14)}"
IO.puts "1969: #{Day01.Fuel.required_for(1969)}"
IO.puts "100756: #{Day01.Fuel.required_for(100756)}"

IO.puts "12: #{Day01.Fuel.total_for(12)}"
IO.puts "14: #{Day01.Fuel.total_for(14)}"
IO.puts "1969: #{Day01.Fuel.total_for(1969)}"
IO.puts "100756: #{Day01.Fuel.total_for(100756)}"

File.stream!("input.txt", [], :line)
|> Enum.map(&(Integer.parse(&1)))
|> Enum.map(fn {i, _} -> i end)
|> Enum.map(&(Day01.Fuel.total_for(&1)))
|> Enum.reduce(fn fuel, tot -> tot + fuel end)
|> IO.puts
