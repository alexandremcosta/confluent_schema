defmodule ConfluentSchema do
  @moduledoc """
  Provides cache and validation for confluent schemas.
  """
  alias ConfluentSchema.Cache
  alias ExJsonSchema.Validator

  @type errors :: [{message :: binary, path :: binary}]

  @doc """
  Validates the payload against the schema for the given subject.

  ## Examples

      iex> ConfluentSchema.validate("a string example", "subject")
      {:ok, "a string example"}

      iex> ConfluentSchema.validate("a string example", "unknown-subject")
      {:error, :not_found}

      iex> ConfluentSchema.validate(123, "subject")
      {:error, [{"Type mismatch. Expected String but got Integer.", "#"}]}
  """
  @spec validate(map, binary) ::
          {:ok, map} | {:error, :not_found} | {:error, errors} | no_return
  def validate(payload, subject) do
    with {:ok, schema} <- Cache.get(subject),
         :ok <- Validator.validate(schema, payload) do
      {:ok, payload}
    end
  end
end
