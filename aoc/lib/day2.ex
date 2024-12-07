defmodule Day2 do
  def part1(file) do
    file
    |> AOCUtil.lines!()
    |> Enum.map(fn x ->
      x
      |> String.split()
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.count(&safe?(&1))
  end

  defp safe?(list) do
    list = list |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [a, b] -> a - b end)

    Enum.all?(list, fn x -> x > 0 and x <= 3 end) ||
      Enum.all?(list, fn x -> x >= -3 and x < 0 end)
  end

  def part2(file) do
    file
    |> AOCUtil.lines!()
    |> Enum.map(fn x ->
      x
      |> String.split()
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.count(&damped_safe?(&1))
  end

  defp damped_safe?(list) do
    if safe?(list),
      do: true,
      else:
        list
        |> Enum.with_index(fn _, index -> List.delete_at(list, index) end)
        |> Enum.any?(&safe?(&1))
  end
end
