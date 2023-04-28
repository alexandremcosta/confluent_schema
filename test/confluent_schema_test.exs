defmodule ConfluentSchemaTest do
  use ExUnit.Case, async: false
  alias ConfluentSchema.Server
  doctest ConfluentSchema

  setup do
    RegistryMock.set_global_subject("subject")
    start_supervised!({Server, [adapter: Tesla.Mock]})
    Server.wait_start()
  end
end
