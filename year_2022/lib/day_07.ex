defmodule Day07 do
  def part_one(input \\ InputFile) do
    input.contents_of(7, :stream)
    |> build_fs()
    |> Map.values()
    |> Enum.filter(fn size -> size <= 100_000 end)
    |> Enum.sum()
  end

  def part_two(input \\ InputFile) do

  end

  defp build_fs(["$ cd /" | rest]), do: build_fs(rest, ["/"], %{["/"] => 0})
  defp build_fs([], _path, fs), do: fs
  defp build_fs(["$ cd .." | rest], path, fs), do: build_fs(rest, tl(path), fs)
  defp build_fs(["$ cd " <> dir | rest], path, fs) do
    path = [dir | path]
    build_fs(rest, path, Map.put(fs, path, 0))
  end
  defp build_fs(["$ ls" | rest], path, fs), do: build_fs(rest, path, fs)
  defp build_fs(["dir " <> _dir | rest], path, fs), do: build_fs(rest, path, fs)
  defp build_fs([file_info | rest], path, fs) do
    size = String.split(file_info, " ") |> hd |> String.to_integer()
    fs = update_fs(fs, path, size)

    build_fs(rest, path, fs)
  end

  defp update_fs(fs, [], _size), do: fs
  defp update_fs(fs, path, size) do
    fs
    |> Map.update!(path, fn prev -> prev + size end)
    |> update_fs(tl(path), size)
  end
end
