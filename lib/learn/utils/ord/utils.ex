defmodule Learn.Utils.Ord.Utils do
  alias Learn.Utils.Ord

  def compare(a, b, ord \\ Ord) do
    cond do
      ord.lt?(a, b) -> :lt
      ord.gt?(a, b) -> :gt
      true -> :eq
    end
  end

  def comparator(ord \\ Ord) do
    fn a, b -> compare(a, b, ord) != :gt end
  end

  def to_eq(ord \\ Ord) do
    %{
      eq?: fn a, b -> compare(a, b, ord) == :eq end,
      not_eq?: fn a, b -> compare(a, b, ord) != :eq end
    }
  end
end
