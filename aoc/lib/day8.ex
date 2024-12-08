defmodule Day8 do
  def part1(file) do
    grid = file |> AOCUtil.character_grid!()

    node_sets =
      Enum.reduce(grid, %{}, fn {{x, y}, c}, acc ->
        if c != ?. do
          Map.update(acc, c, [{x, y}], fn list -> [{x, y} | list] end)
        else
          acc
        end
      end)

    node_sets
    |> Enum.reduce(MapSet.new(), fn {_, list}, acc ->
      list
      |> all_pairs(MapSet.new())
      |> Enum.flat_map(fn {{x1, y1}, {x2, y2}} ->
        delta_x = x1 - x2
        delta_y = y1 - y2

        [{x1 + delta_x, y1 + delta_y}, {x2 - delta_x, y2 - delta_y}]
        |> Enum.filter(&Map.has_key?(grid, &1))
      end)
      |> MapSet.new()
      |> MapSet.union(acc)
    end)
    |> Enum.count()
  end

  defp all_pairs([], pairs), do: pairs
  defp all_pairs([_], pairs), do: pairs

  defp all_pairs([x | rest], pairs),
    do: all_pairs(rest, pairs |> MapSet.union(rest |> Enum.map(&{x, &1}) |> MapSet.new()))

  def part2(file) do
    grid = file |> AOCUtil.character_grid!()

    node_sets =
      Enum.reduce(grid, %{}, fn {{x, y}, c}, acc ->
        if c != ?. do
          Map.update(acc, c, [{x, y}], fn list -> [{x, y} | list] end)
        else
          acc
        end
      end)

    node_sets
    |> Enum.reduce(MapSet.new(), fn {_, list}, acc ->
      list
      |> all_pairs(MapSet.new())
      |> Enum.flat_map(fn {{x1, y1}, {x2, y2}} ->
        delta_x = x1 - x2
        delta_y = y1 - y2
        gcd = Integer.gcd(delta_x, delta_y)
        delta_x = (delta_x / gcd) |> floor()
        delta_y = (delta_y / gcd) |> floor()

        find_nodes({x1, y1}, delta_x, delta_y, grid) ++
          find_nodes({x2, y2}, -delta_x, -delta_y, grid)
      end)
      |> MapSet.new()
      |> MapSet.union(acc)
    end)
    |> Enum.count()
  end

  defp find_nodes({x, y}, delta_x, delta_y, grid),
    do: find_nodes({x, y}, delta_x, delta_y, grid, [])

  defp find_nodes({x, y}, delta_x, delta_y, grid, list) do
    if Map.has_key?(grid, {x, y}) do
      find_nodes({x + delta_x, y + delta_y}, delta_x, delta_y, grid, [{x, y} | list])
    else
      list
    end
  end
end
