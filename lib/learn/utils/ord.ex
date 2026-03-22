defprotocol Learn.Utils.Ord do
  @fallback_to_any true

  def lt?(a, b)
  def le?(a, b)
  def gt?(a, b)
  def ge?(a, b)
end

defimpl Learn.Utils.Ord, for: Any do
  def lt?(a, b), do: a < b
  def le?(a, b), do: a <= b
  def gt?(a, b), do: a > b
  def ge?(a, b), do: a >= b
end

defimpl Learn.Utils.Ord, for: DateTime do
  def lt?(%DateTime{} = a, %DateTime{} = b), do: DateTime.compare(a, b) == :lt
  def le?(%DateTime{} = a, %DateTime{} = b), do: DateTime.compare(a, b) in [:lt, :eq]
  def gt?(%DateTime{} = a, %DateTime{} = b), do: DateTime.compare(a, b) == :gt
  def ge?(%DateTime{} = a, %DateTime{} = b), do: DateTime.compare(a, b) in [:gt, :eq]
end
