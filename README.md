# ConfluentSchema

Provides cache and validation for confluent schemas that are pulled from a registry.

It mixes [ConfluentSchemaRegistry](https://github.com/cogini/confluent_schema_registry) with
[ExJsonSchema](https://github.com/jonasschmidt/ex_json_schema/) and [ETS](https://www.erlang.org/doc/man/ets.html)
to provide fast validation for schemas registered remotely on a registry server like [confluent.cloud](confluent.cloud).

## Installation

```elixir
def deps do
  [
    {:confluent_schema, "~> 0.1.0"}
  ]
end
```

## Usage
On `application.ex`:

```elixir
  def start(_type, _args) do
    confluent_schema_opts = [
      base_url: "https://foobar.region.aws.confluent.cloud",
      username: "key",
      password: "secret",
      period: :timer.minutes(1),
      debug: true
    ]

    children = [{ConfluentSchema.Server, confluent_schema_opts}]

    supervisor_opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, supervisor_opts)
  end
```

Then you can use your confluent schema registry to validate payloads for a subject:

```elixir
payload = %{foo: "bar"}
ConfluentSchema.validate(payload, "my-subject")
```

Use the `period` option to customize the interval to refresh schemas on the cache. It is 5 minutes by default.
Use the `debug` option to log errors in case schemas aren't correctly fetched from the registry.
