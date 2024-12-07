defmodule Day7 do
  def part1(file) do
    file
    |> AOCUtil.lines!()
    |> Enum.map(fn x -> x |> String.split(": ") end)
    |> Enum.map(fn [total, list] ->
      {String.to_integer(total), list |> String.split() |> Enum.map(&String.to_integer(&1))}
    end)
    |> Enum.filter(&valid?(&1))
    |> Enum.map(fn {total, _} -> total end)
    |> Enum.sum()
  end

  defp valid?({total, values}), do: valid?(total, values, [])
  defp valid?(total, [], possible), do: total in possible
  defp valid?(total, [val | rest], []), do: valid?(total, rest, [val])

  defp valid?(total, [val | rest], possible),
    do:
      valid?(
        total,
        rest,
        possible
        |> Enum.flat_map(fn x -> [x + val, x * val] end)
        |> MapSet.new()
        |> MapSet.to_list()
      )

  def part2(file) do
    file
    |> AOCUtil.lines!()
    |> Enum.map(fn x -> x |> String.split(": ") end)
    |> Enum.map(fn [total, list] ->
      {String.to_integer(total), list |> String.split() |> Enum.map(&String.to_integer(&1))}
    end)
    |> Enum.filter(&valid_extended?(&1))
    |> Enum.map(fn {total, _} -> total end)
    |> Enum.sum()
  end

  defp valid_extended?({total, values}), do: valid_extended?(total, values, [])
  defp valid_extended?(total, [], possible), do: total in possible
  defp valid_extended?(total, [val | rest], []), do: valid_extended?(total, rest, [val])

  defp valid_extended?(total, [val | rest], possible),
    do:
      valid_extended?(
        total,
        rest,
        possible
        |> Enum.flat_map(fn x -> [x + val, x * val, "#{x}#{val}" |> String.to_integer()] end)
        |> MapSet.new()
        |> MapSet.to_list()
      )
end
