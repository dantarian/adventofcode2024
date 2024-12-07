defmodule Day1 do
  def part1(file) do
    file
    |> get_lists()
    |> Tuple.to_list()
    |> Enum.map(&Enum.sort(&1))
    |> Enum.zip_reduce(0, fn [a, b], acc -> acc + abs(a - b) end)
  end

  def part2(file) do
    {l1, l2} = get_lists(file)

    frequencies = Enum.frequencies(l2)

    l1 |> Enum.reduce(0, fn x, acc -> acc + x * Map.get(frequencies, x, 0) end)
  end

  defp get_lists(file) do
    file
    |> AOCUtil.lines!()
    |> Enum.map(fn x ->
      x |> String.split() |> Enum.map(&String.to_integer(&1)) |> List.to_tuple()
    end)
    |> Enum.unzip()
  end
end
