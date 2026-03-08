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

  def schema, do: @schema

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
end
