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
  def at(x, y, z), do: %__MODULE__{position: Day12.Vector.new(x, y, z)}

  def step(moons, 0), do: moons
  def step(moons, n) do
     moons
     |> apply_gravity([])
     |> Enum.map(&move/1)
     |> step(n - 1)
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

  defp apply_gravity([], moons), do: moons
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
