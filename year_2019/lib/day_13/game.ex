defmodule Day13.Game do
  defstruct pid: nil, paddle: {0, 0}, ball: {0, 0}

  def output do
    machine = 13 |> InputFile.contents_of() |> Intcode.build
    my_pid = self()
    spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
    retrieve_output([])
    |> Enum.chunk_every(3)
    |> build_screen(%{})
    |> Map.values
    |> Enum.count(&(&1 == 2))
    |> IO.inspect
  end

  def play do
    machine = 13 |> InputFile.contents_of() |> Intcode.build
    my_pid = self()
    IO.ANSI.clear() |> IO.write
    # graphics = spawn(&paint/0)
    prog = spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
    game = %__MODULE__{pid: prog}
    paint(game)
    IO.ANSI.clear() |> IO.write
  end

  def input_loop(pid) do
    if Process.alive?(pid) do

      case IO.getn(:stdio, nil, 2) do
        "j\n" ->
           send pid, -1
       "jj\n" ->
          send pid, -1
          send pid, -1
       "jjj\n" ->
          send pid, -1
          send pid, -1
          send pid, -1
       "k\n" ->
           send pid, 0
        "l\n" ->
           send pid, 1
      end
      input_loop(pid)
    end
  end

  def paint(%__MODULE__{} = game) do
    case {recv(), recv(), recv()} do
      {-1, 0, score} ->
        paint_score(score)
        game
      {x, y, 0} ->
        paint({x, y}, :empty)
        game
      {x, y, 1} ->
        paint({x, y}, :wall)
        game
      {x, y, 2} ->
        paint({x, y}, :block)
        game
      {x, y, 3} ->
        paint({x, y}, :paddle)
        %__MODULE__{game | paddle: {x, y}}
      {x, y, 4} ->
        paint({x, y}, :ball)
        :timer.sleep(1)
        ball_movement(game, {x, y})
        %__MODULE__{game | ball: {x, y}}
      a -> IO.inspect a
    end
    |> paint
  end

  def ball_movement(%__MODULE__{ball: {_, old_y}} = game, {_x, y}) when old_y <= y, do: send game.pid, 0
  def ball_movement(%__MODULE__{ball: {old_x, old_y}} = game, {x, y}) do
    # Figure out where the ball will hit the paddle's y coordinate and send the paddle there
    delta_x = x - old_x
    delta_y = y - old_y
    future_x = ((elem(game.paddle, 1) - y) * delta_x) + x
    # IO.puts ("MOVE TO #{future_x}")
    case (future_x - elem(game.paddle, 0)) do
      0 -> send game.pid, 0
      moves ->
        for x <- 0..moves do
          send game.pid, moves / abs(moves)
        end
    end
  end

  def recv do
    receive do
      a -> a
    end
  end

  def paint_score(score) do
    IO.ANSI.cursor(0, 0) |> IO.write
    IO.write(Integer.to_string(score))
  end
  def paint(coords, :empty), do: paint(coords, " ")
  def paint(coords, :wall), do: paint(coords, "|")
  def paint(coords, :block), do: paint(coords, "#")
  def paint(coords, :paddle), do: paint(coords, "_")
  def paint(coords, :ball), do: paint(coords, "*")
  def paint({x, y}, c) do
    IO.ANSI.cursor(y, x + 1) |> IO.write
    IO.write(c)
    #IO.puts "#{c} at #{x}, #{y}"
  end

  def build_screen([], screen), do: screen
  def build_screen([[x, y, val] | rest], screen) do
    build_screen(rest, Map.put(screen, {x, y}, val))
  end

  def retrieve_output(msgs) do
    msg = receive do
      a -> a
    after
      1_000 -> false
    end
    if msg do
      retrieve_output([msg | msgs])
    else
      Enum.reverse(msgs)
    end
  end
end
