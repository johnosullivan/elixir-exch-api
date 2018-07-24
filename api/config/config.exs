# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: MyAPI,
  ecto_repos: [MyAPI.Repo]

# Configures the endpoint
config :api, MyAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1gB4J9QAEKuMONRBZC381lNg0UyFLL4O+Nys12Mrh+DmHd2GpbvxPtlJEk4MN+/n",
  render_errors: [view: MyAPIWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MyAPI.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
