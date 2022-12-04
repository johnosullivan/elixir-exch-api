use Mix.Config

config :bcrypt_elixir, :log_rounds, 4

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api, MyAPIWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :api, MyAPI.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
