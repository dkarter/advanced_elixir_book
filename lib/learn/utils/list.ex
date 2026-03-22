defmodule Learn.Utils.List do
  alias Learn.Utils.Ord

  def sort(list, ord \\ Ord) do
    Enum.sort(list, Ord.Utils.comparator(ord))
  end
end
