defmodule Day12.Moon do
  defstruct position: %Day12.Vector{}, velocity: %Day12.Vector{}

  def run(1) do
    # Hardcode positions, instead of trying to parse the input file
    [
      at(-7, -1, 6),
      at(6, -9, -9),
      at(-12, 2, -7),
      at(4, -17, -12)
    ]
    |> step(1_000)
    |> total_energy
    |> IO.puts
  end
  def run(2) do
    # Hardcode positions, instead of trying to parse the input file
    moons = [
      at(-7, -1, 6),
      at(6, -9, -9),
      at(-12, 2, -7),
      at(4, -17, -12)
    ]

    {x, y, z} = detect_periods(moons)

    ElixirMath.lcm(x, y) |> ElixirMath.lcm(z) |> IO.puts
  end
  def at(x, y, z), do: %__MODULE__{position: Day12.Vector.new(x, y, z)}

  def step(moons, 0), do: moons
  def step(moons, n) do
     moons
     |> apply_gravity([])
     |> Enum.map(&move/1)
     |> step(n - 1)
  end

  def detect_periods(moons) do
    {xk, yk, zk} = keys_for(moons)
    do_detect_periods(moons, %{xk => 0}, %{yk => 0}, %{zk => 0}, {0, 0, 0}, 1)
  end

  defp do_detect_periods(_, _, _, _, {x, y, z}, _) when x != 0 and y != 0 and z != 0, do: {x, y, z}
  defp do_detect_periods(moons, xs, ys, zs, {xp, yp, zp}, n) do
    moons = step(moons, 1)
    {xk, yk, zk} = keys_for(moons)
    xp = if xp == 0 && Map.has_key?(xs, xk) do
      n - Map.get(xs, xk)
    else
      xp
    end
    yp = if yp == 0 && Map.has_key?(ys, yk) do
      n - Map.get(ys, yk)
    else
      yp
    end
    zp = if zp == 0 && Map.has_key?(zs, zk) do
      n - Map.get(zs, zk)
    else
      zp
    end

    do_detect_periods(moons, Map.put(xs, xk, n), Map.put(ys, yk, n), Map.put(zs, zk, n), {xp, yp, zp}, n + 1)
  end

  defp keys_for([a, b, c, d]) do
    {
      [a.position.x, a.velocity.x, b.position.x, b.velocity.x, c.position.x, c.velocity.x, d.position.x, d.velocity.x],
      [a.position.y, a.velocity.y, b.position.y, b.velocity.y, c.position.y, c.velocity.y, d.position.y, d.velocity.y],
      [a.position.z, a.velocity.z, b.position.z, b.velocity.z, c.position.z, c.velocity.z, d.position.z, d.velocity.z]
    }
  end

  def total_energy(moons) do
    moons
    |> Enum.map(&energy_of/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def gravitate(a, b) do
    vec = Day12.Vector.new(velo_adjust(a.position.x, b.position.x),
      velo_adjust(a.position.y, b.position.y),
      velo_adjust(a.position.z, b.position.z))
    %Day12.Moon{a | velocity: Day12.Vector.adjust(a.velocity, vec)}
  end

  def move(moon), do: %__MODULE__{moon | position: Day12.Vector.adjust(moon.position, moon.velocity)}

  defp apply_gravity([], moons), do: moons |> Enum.reverse
  defp apply_gravity([moon | rest], done) do
    moon = Enum.reduce(rest, moon, fn x, acc -> gravitate(acc, x) end)
    moon = Enum.reduce(done, moon, fn x, acc -> gravitate(acc, x) end)

    apply_gravity(rest, [moon | done])
  end

  defp energy_of(moon) do
    potential = abs(moon.position.x) + abs(moon.position.y) + abs(moon.position.z)
    kinetic = abs(moon.velocity.x) + abs(moon.velocity.y) + abs(moon.velocity.z)
    potential * kinetic
  end

  defp velo_adjust(a, a), do: 0
  defp velo_adjust(a, b) when a > b, do: -1
  defp velo_adjust(a, b) when a < b, do: 1
end
