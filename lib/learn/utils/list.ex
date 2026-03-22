defmodule Learn.Utils.List do
  alias Learn.Utils.Ord

  def sort(list, ord \\ Ord) do
    Enum.sort(list, Ord.Utils.comparator(ord))
  end

  def uniq(list, eq_functions) do
    list
    |> Enum.reduce([], fn x, acc ->
      if Enum.any?(acc, fn y -> eq_functions.eq?.(x, y) end) do
        acc
      else
        [x | acc]
      end
    end)
    |> Enum.reverse()
  end

  def strict_sort(list, ord \\ Ord) do
    list
    |> uniq(Ord.Utils.to_eq(ord))
    |> sort(ord)
  end
end
