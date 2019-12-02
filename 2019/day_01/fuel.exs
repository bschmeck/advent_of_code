defmodule Day01.Fuel do
  def required_for(mass) do
    div(mass, 3) - 2
  end
end

IO.puts "12: #{Day01.Fuel.required_for(12)}"
IO.puts "14: #{Day01.Fuel.required_for(14)}"
IO.puts "1969: #{Day01.Fuel.required_for(1969)}"
IO.puts "100756: #{Day01.Fuel.required_for(100756)}"

File.stream!("input.txt", [], :line)
|> Enum.map(&(Integer.parse(&1)))
|> Enum.map(fn {i, _} -> i end)
|> Enum.map(&(Day01.Fuel.required_for(&1)))
|> Enum.reduce(fn fuel, tot -> tot + fuel end)
|> IO.puts
