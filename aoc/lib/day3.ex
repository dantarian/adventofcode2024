defmodule Day3 do
  def part1(file) do
    input = file |> File.read!()

    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, input, capture: :all_but_first)
    |> Enum.map(fn list -> list |> Enum.map(&String.to_integer(&1)) |> Enum.product() end)
    |> Enum.sum()
  end

  def part2(file) do
    input = file |> File.read!()

    Regex.scan(~r/(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))/, input, capture: :first)
    |> Enum.reduce({0, :do}, fn [elem], {sum, apply} ->
      cond do
        "do()" == elem ->
          {sum, :do}

        "don't()" == elem ->
          {sum, :dont}

        :dont == apply ->
          {sum, :dont}

        true ->
          {(Regex.scan(~r/\d{1,3}/, elem, capture: :first)
            |> Enum.map(fn [x] -> String.to_integer(x) end)
            |> Enum.product()) + sum, :do}
      end
    end)
  end
end
