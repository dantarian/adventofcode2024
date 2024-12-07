defmodule Day5 do
  def part1(file) do
    {orders, updates} = file |> parse()

    updates
    |> Enum.filter(&valid?(&1, orders))
    |> Enum.map(fn x -> x |> Enum.fetch!(floor(length(x) / 2)) |> String.to_integer() end)
    |> Enum.sum()
  end

  def parse(file) do
    [orders, updates] = file |> AOCUtil.blocks!()

    orders =
      orders
      |> String.split("\n")
      |> Enum.reject(fn x -> String.length(x) == 0 end)
      |> Enum.map(fn <<a::binary-size(2), "|", b::binary-size(2)>> -> {a, b} end)
      |> MapSet.new()

    updates =
      updates
      |> String.split("\n")
      |> Enum.reject(fn x -> String.length(x) == 0 end)
      |> Enum.map(fn x -> String.split(x, ",") end)

    {orders, updates}
  end

  def valid?([], _), do: true
  def valid?([_], _), do: true

  def valid?([a, b | rest], orders) do
    if MapSet.member?(orders, {a, b}), do: valid?([b | rest], orders), else: false
  end

  def part2(file) do
    {orders, updates} = file |> parse()

    updates
    |> Enum.reject(&valid?(&1, orders))
    |> Enum.map(fn x -> Enum.sort(x, fn a, b -> MapSet.member?(orders, {a, b}) end) end)
    |> Enum.map(fn x -> x |> Enum.fetch!(floor(length(x) / 2)) |> String.to_integer() end)
    |> Enum.sum()
  end
end
