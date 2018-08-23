defmodule MyAPI.Mixfile do
  use Mix.Project

  def project do
    [
      app: :api,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {MyAPI.Application, []},
      extra_applications: [:logger, :runtime_tools, :ethereumex, :jsonrpc2, :poison]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.3"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:bcrypt_elixir, "~> 1.0"},
      {:corsica, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:elixir_uuid, "~> 1.2"},
      {:guardian, "~> 1.0"},
      {:decimal, "~> 1.0"},
      {:ethereumex, "~> 0.3.3"},
      {:hexate,  ">= 0.6.0"},
      {:faker, "~> 0.10.0"},
      {:eastar, "~> 0.4.2"},
      {:jsonrpc2, "~> 1.0"},
      {:abi, "~> 0.1.12"},
      {:blockchain, "~> 0.1.6"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #     {:abi, "~> 0.1.8"}
  #     File.read!("abi/test.json") |> Poison.decode! |> ABI.parse_specification |> Enum.find(&(&1.function == "setting")) |> ABI.encode(["john was here"]) |> Base.encode16(case: :lower)
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
