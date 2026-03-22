defmodule Learn.FastPass do
  @schema Zoi.struct(
            __MODULE__,
            %{
              id: Zoi.integer(gte: 0) |> Zoi.nullable(),
              ride: Learn.Ride.schema(),
              time: Zoi.datetime()
            },
            coerce: true,
            unrecognized_keys: :error
          )

  @type t :: unquote(Zoi.type_spec(@schema))
  @enforce_keys Zoi.Struct.enforce_keys(@schema)
  defstruct Zoi.Struct.struct_fields(@schema)

  @new_opts_schema @schema.fields |> Zoi.keyword(coerce: true, unrecognized_keys: :error)
  @type new_opts_t :: unquote(Zoi.type_spec(@new_opts_schema))

  @spec new(binary(), new_opts_t()) :: {:ok, t()} | {:error, Zoi.Errors.t()}
  def new(ride, time) do
    opts =
      [
        id: :erlang.unique_integer([:positive]),
        ride: ride,
        time: time
      ]

    with {:ok, parsed} <- Zoi.parse(@new_opts_schema, opts, coerce: true) do
      {:ok, struct(__MODULE__, parsed)}
    end
  end

  @change_opts_fields @new_opts_schema.fields
                      |> Keyword.drop([:id])
                      |> Keyword.new(fn {field, schema} -> {field, Zoi.optional(schema)} end)

  @change_opts_schema Zoi.keyword(
                        @change_opts_fields,
                        coerce: @new_opts_schema.coerce,
                        unrecognized_keys: @new_opts_schema.unrecognized_keys
                      )
  @type change_opts_t :: unquote(Zoi.type_spec(@change_opts_schema))

  @spec change(t(), change_opts_t()) :: {:ok, t()} | {:error, Zoi.Errors.t()}
  def change(fast_pass, updated_opts) do
    safe_changes = Keyword.drop(updated_opts, [:id])

    with {:ok, parsed} <- Zoi.parse(@change_opts_schema, safe_changes, coerce: true) do
      {:ok, struct(fast_pass, parsed)}
    end
  end

  def schema, do: @schema
end

defimpl Learn.Utils.Eq, for: Learn.FastPass do
  def eq?(%Learn.FastPass{time: t1}, %Learn.FastPass{time: t2}), do: Learn.Utils.Eq.eq?(t1, t2)

  def not_eq?(%Learn.FastPass{time: t1}, %Learn.FastPass{time: t2}),
    do: Learn.Utils.Eq.not_eq?(t1, t2)
end

defimpl Learn.Utils.Ord, for: Learn.FastPass do
  alias Learn.Utils.Ord
  alias Learn.FastPass

  def lt?(%FastPass{time: v1}, %FastPass{time: v2}), do: Ord.lt?(v1, v2)
  def le?(%FastPass{time: v1}, %FastPass{time: v2}), do: Ord.le?(v1, v2)
  def gt?(%FastPass{time: v1}, %FastPass{time: v2}), do: Ord.gt?(v1, v2)
  def ge?(%FastPass{time: v1}, %FastPass{time: v2}), do: Ord.ge?(v1, v2)
end
