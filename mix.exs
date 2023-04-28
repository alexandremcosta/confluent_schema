defmodule ConfluentSchema.MixProject do
  use Mix.Project

  def project do
    [
      app: :confluent_schema,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:confluent_schema_registry, "~> 0.1.1"},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_json_schema, "~> 0.9.2"},
      {:jason, "~> 1.0"}
    ]
  end
end
