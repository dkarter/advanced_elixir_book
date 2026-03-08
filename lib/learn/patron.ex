defmodule Learn.Patron do
  @schema Zoi.struct(
            __MODULE__,
            %{
              id: Zoi.integer(gte: 0) |> Zoi.nullable(),
              name: Zoi.string(min_length: 1) |> Zoi.trim() |> Zoi.required(),
              age_years: Zoi.integer(gte: 1) |> Zoi.required(),
              height_ft: Zoi.integer(gte: 1) |> Zoi.required(),
              ticket_tier:
                Zoi.atom() |> Zoi.one_of([:basic, :premium, :vip]) |> Zoi.default(:basic),
              fast_passes: Zoi.list(Learn.FastPass.schema()) |> Zoi.default([]),
              reward_points: Zoi.integer(gte: 0) |> Zoi.default(0),
              likes: Zoi.list(Zoi.string()) |> Zoi.default([]),
              dislikes: Zoi.list(Zoi.string()) |> Zoi.default([])
            },
            coerce: true,
            unrecognized_keys: :error
          )

  @type t :: unquote(Zoi.type_spec(@schema))
  @enforce_keys Zoi.Struct.enforce_keys(@schema)
  defstruct Zoi.Struct.struct_fields(@schema)

  @opts_schema @schema.fields |> Zoi.keyword(coerce: true, unrecognized_keys: :error)
  @type opts_t :: unquote(Zoi.type_spec(@opts_schema))

  @spec new(binary(), opts_t()) :: {:ok, t()} | {:error, Zoi.Errors.t()}
  def new(name, opts \\ []) do
    merged_opts =
      opts
      |> Keyword.put(:name, name)
      |> Keyword.put_new(:id, :erlang.unique_integer([:positive]))

    with {:ok, parsed} <- Zoi.parse(@opts_schema, merged_opts, coerce: true) do
      {:ok, struct(__MODULE__, parsed)}
    end
  end

  @change_opts_fields @opts_schema.fields
                      |> Keyword.drop([:id])
                      |> Keyword.new(fn {field, schema} -> {field, Zoi.optional(schema)} end)

  @change_opts_schema Zoi.keyword(
                        @change_opts_fields,
                        coerce: @opts_schema.coerce,
                        unrecognized_keys: @opts_schema.unrecognized_keys
                      )
  @type change_opts_t :: unquote(Zoi.type_spec(@change_opts_schema))

  @spec change(t(), change_opts_t()) :: {:ok, t()} | {:error, Zoi.Errors.t()}
  def change(%__MODULE__{} = patron, changes) do
    safe_changes = Keyword.drop(changes, [:id])

    with {:ok, parsed} <- Zoi.parse(@change_opts_schema, safe_changes, coerce: true) do
      {:ok, struct(patron, parsed)}
    end
  end

  def schema, do: @schema
end
