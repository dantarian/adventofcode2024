defmodule Day6 do
  def part1(file) do
    grid = file |> AOCUtil.character_grid!()
    start = grid |> Enum.find_value(nil, fn {k, v} -> if v == ?^, do: k end)
    follow_path(grid, start, :up, MapSet.new([start])) |> MapSet.size()
  end

  defp next({x, y}, :up), do: {x, y - 1}
  defp next({x, y}, :down), do: {x, y + 1}
  defp next({x, y}, :left), do: {x - 1, y}
  defp next({x, y}, :right), do: {x + 1, y}

  defp next_direction(:up), do: :right
  defp next_direction(:right), do: :down
  defp next_direction(:down), do: :left
  defp next_direction(:left), do: :up

  defp follow_path(grid, location, direction, visited) do
    next_location = next(location, direction)

    case Map.get(grid, next_location) do
      ?. -> follow_path(grid, next_location, direction, MapSet.put(visited, next_location))
      ?^ -> follow_path(grid, next_location, direction, MapSet.put(visited, next_location))
      ?# -> follow_path(grid, location, next_direction(direction), visited)
      nil -> visited
    end
  end

  def part2(file) do
    grid = file |> AOCUtil.character_grid!()
    start = grid |> Enum.find_value(nil, fn {k, v} -> if v == ?^, do: k end)

    grid
    |> follow_path(start, :up, MapSet.new([start]))
    |> Enum.reject(fn x -> x == start end)
    |> Enum.filter(&is_loop?(Map.put(grid, &1, ?#), start, :up, MapSet.new()))
    |> Enum.count()
  end

  defp is_loop?(grid, location, direction, previous) do
    next_location = next(location, direction)

    if MapSet.member?(previous, {location, direction}) do
      true
    else
      case(Map.get(grid, next_location)) do
        ?. ->
          is_loop?(grid, next_location, direction, MapSet.put(previous, {location, direction}))

        ?^ ->
          is_loop?(grid, next_location, direction, MapSet.put(previous, {location, direction}))

        ?# ->
          is_loop?(
            grid,
            location,
            next_direction(direction),
            MapSet.put(previous, {location, direction})
          )

        nil ->
          false
      end
    end
  end
end
