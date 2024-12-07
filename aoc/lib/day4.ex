defmodule Day4 do
  def part1(file) do
    grid = file |> AOCUtil.character_grid!()

    grid
    |> Enum.map(fn {{x, y}, c} ->
      case c do
        ?X -> count_from(grid, {x, y})
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  defp count_from(grid, {x, y}) do
    [
      Map.get(grid, {x + 1, y}) == ?M and Map.get(grid, {x + 2, y}) == ?A and
        Map.get(grid, {x + 3, y}) == ?S,
      Map.get(grid, {x - 1, y}) == ?M and Map.get(grid, {x - 2, y}) == ?A and
        Map.get(grid, {x - 3, y}) == ?S,
      Map.get(grid, {x, y + 1}) == ?M and Map.get(grid, {x, y + 2}) == ?A and
        Map.get(grid, {x, y + 3}) == ?S,
      Map.get(grid, {x, y - 1}) == ?M and Map.get(grid, {x, y - 2}) == ?A and
        Map.get(grid, {x, y - 3}) == ?S,
      Map.get(grid, {x + 1, y + 1}) == ?M and Map.get(grid, {x + 2, y + 2}) == ?A and
        Map.get(grid, {x + 3, y + 3}) == ?S,
      Map.get(grid, {x - 1, y + 1}) == ?M and Map.get(grid, {x - 2, y + 2}) == ?A and
        Map.get(grid, {x - 3, y + 3}) == ?S,
      Map.get(grid, {x + 1, y - 1}) == ?M and Map.get(grid, {x + 2, y - 2}) == ?A and
        Map.get(grid, {x + 3, y - 3}) == ?S,
      Map.get(grid, {x - 1, y - 1}) == ?M and Map.get(grid, {x - 2, y - 2}) == ?A and
        Map.get(grid, {x - 3, y - 3}) == ?S
    ]
    |> Enum.count(& &1)
  end

  def part2(file) do
    grid = file |> AOCUtil.character_grid!()

    grid
    |> Enum.count(fn {{x, y}, c} -> c == ?A and cross_mas?(grid, {x, y}) end)
  end

  def cross_mas?(grid, {x, y}),
    do:
      ((Map.get(grid, {x + 1, y + 1}) == ?M and Map.get(grid, {x - 1, y - 1}) == ?S) or
         (Map.get(grid, {x - 1, y - 1}) == ?M and Map.get(grid, {x + 1, y + 1}) == ?S)) and
        ((Map.get(grid, {x - 1, y + 1}) == ?M and Map.get(grid, {x + 1, y - 1}) == ?S) or
           (Map.get(grid, {x + 1, y - 1}) == ?M and Map.get(grid, {x - 1, y + 1}) == ?S))
end
