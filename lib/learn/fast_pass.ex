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
end
