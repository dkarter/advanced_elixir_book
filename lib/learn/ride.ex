defmodule Learn.Ride do
  @schema Zoi.struct(
            __MODULE__,
            %{
              id: Zoi.integer(gte: 0) |> Zoi.nullable(),
              name: Zoi.string(min_length: 1) |> Zoi.trim() |> Zoi.required(),
              min_age_years: Zoi.integer(gte: 0) |> Zoi.default(0),
              min_height_ft: Zoi.integer(gte: 0) |> Zoi.default(0),
              wait_time: Zoi.integer(gte: 0) |> Zoi.default(0),
              online: Zoi.boolean() |> Zoi.default(true),
              tags: Zoi.list(Zoi.atom()) |> Zoi.default([])
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
  def new(name, opts \\ []) do
    merged_opts =
      opts
      |> Keyword.put(:name, name)
      |> Keyword.put_new(:id, :erlang.unique_integer([:positive]))

    with {:ok, parsed} <- Zoi.parse(@new_opts_schema, merged_opts, coerce: true) do
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
  def change(%__MODULE__{} = ride, changes) do
    safe_changes = Keyword.drop(changes, [:id])

    with {:ok, parsed} <- Zoi.parse(@change_opts_schema, safe_changes, coerce: true) do
      {:ok, struct(ride, parsed)}
    end
  end

  def schema, do: @schema
end

defimpl Learn.Utils.Ord, for: Learn.Ride do
  alias Learn.Utils.Ord
  alias Learn.Ride

  def lt?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.lt?(v1, v2)
  def le?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.le?(v1, v2)
  def gt?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.gt?(v1, v2)
  def ge?(%Ride{name: v1}, %Ride{name: v2}), do: Ord.ge?(v1, v2)
end
