defprotocol Learn.Utils.Eq do
  @fallback_to_any true

  def eq?(a, b)

  def not_eq?(a, b)
end

defimpl Learn.Utils.Eq, for: Any do
  def eq?(%{id: id1}, %{id: id2}), do: id1 == id2
  def eq?(a, b), do: a == b

  def not_eq?(%{id: id1}, %{id: id2}), do: id1 != id2
  def not_eq?(a, b), do: a != b
end
