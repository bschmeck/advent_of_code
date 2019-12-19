defmodule Day11.Robot do
  defstruct direction: :up, location: {0, 0}

  def panel_count() do
    paint(0) |> Map.values |> Enum.count
  end

  def registration() do
    canvas = paint(1)
    {min_x, max_x} = canvas |> Map.keys |> Enum.map(fn({x, _y}) -> x end) |> Enum.min_max
    {min_y, max_y} = canvas |> Map.keys |> Enum.map(fn({_x, y}) -> y end) |> Enum.min_max

    for y <- max_y..min_y do
      for x <- min_x..max_x do
        case Map.get(canvas, {x, y}, 0) do
          0 -> IO.write "."
          1 -> IO.write "#"
        end

        if x == max_x, do: IO.puts("")
      end
    end
  end

  def paint(start_color) do
    robot = %__MODULE__{}
    machine = InputFile.contents_of(11) |> Intcode.build
    my_pid = self()
    prog = spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
    step(robot, %{robot.location => start_color}, prog)
  end

  def step(robot, canvas, prog) do
    if Process.alive?(prog) do
      color = Map.get(canvas, robot.location, 0)
      send prog, color
      paint = receive do
        a -> a
      end
      turn = receive do
        0 -> :left
        1 -> :right
      end
      canvas = Map.put(canvas, robot.location, paint)
      robot = move(robot, turn)

      step(robot, canvas, prog)
    else
      canvas
    end
  end

  def move(%__MODULE__{direction: :down} = robot, :left), do: do_move(robot, :right)
  def move(%__MODULE__{direction: :down} = robot, :right), do: do_move(robot, :left)
  def move(%__MODULE__{direction: :left} = robot, :left), do: do_move(robot, :down)
  def move(%__MODULE__{direction: :left} = robot, :right), do: do_move(robot, :up)
  def move(%__MODULE__{direction: :right} = robot, :left), do: do_move(robot, :up)
  def move(%__MODULE__{direction: :right} = robot, :right), do: do_move(robot, :down)
  def move(%__MODULE__{direction: :up} = robot, :left), do: do_move(robot, :left)
  def move(%__MODULE__{direction: :up} = robot, :right), do: do_move(robot, :right)

  defp do_move(%__MODULE__{location: {x, y}} = robot, :down), do: %__MODULE__{robot | direction: :down, location: {x, y-1}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :left), do: %__MODULE__{robot | direction: :left, location: {x-1, y}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :right), do: %__MODULE__{robot | direction: :right, location: {x+1, y}}
  defp do_move(%__MODULE__{location: {x, y}} = robot, :up), do: %__MODULE__{robot | direction: :up, location: {x, y+1}}
end
