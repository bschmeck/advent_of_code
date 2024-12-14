defmodule Day13 do
  defmodule Machine do
    defstruct [:xA, :xB, :yA, :yB, :goal_x, :goal_y]

    def parse(raw) do
      [a, b, goal] = String.split(raw, "\n", trim: true)
      {xA, yA} = parse_line(a)
      {xB, yB} = parse_line(b)
      {goal_x, goal_y} = parse_line(goal)

      %__MODULE__{xA: xA, yA: yA, xB: xB, yB: yB, goal_x: goal_x, goal_y: goal_y}
    end

    def parse_line(str) do
      [_match, x, y] = Regex.run(~r{X[+=](\d+), Y[+=](\d+)}, str)

      {String.to_integer(x), String.to_integer(y)}
    end
  end

  def part_one(input \\ InputFile) do
    input.contents_of(13)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&Machine.parse/1)
    |> Enum.map(&solve/1)
    |> Enum.filter(&whole?/1)
    |> Enum.map(fn {a, b} -> 3 * a + b end)
    |> Enum.sum()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(13)
    |> String.split("\n\n", trim: true)
    |> Enum.map(&Machine.parse/1)
    |> Enum.map(fn machine -> %Machine{machine | goal_x: 10000000000000 + machine.goal_x, goal_y: 10000000000000 + machine.goal_y} end)
    |> Enum.map(&solve/1)
    |> Enum.filter(&whole?/1)
    |> Enum.map(fn {a, b} -> 3 * a + b end)
    |> Enum.sum()
  end

  def solve(%Machine{} = machine) do
    denom = machine.xA * machine.yB - machine.xB * machine.yA

    {(machine.yB * machine.goal_x - machine.xB * machine.goal_y) / denom, (machine.xA * machine.goal_y - machine.yA * machine.goal_x) / denom}
  end

  def whole?({x, y}) do
    round(x) == x && round(y) == y
  end
end
