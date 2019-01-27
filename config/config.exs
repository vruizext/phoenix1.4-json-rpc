# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :json_rpc_api,
  ecto_repos: [JsonRpcApi.Repo]

# Configures the endpoint
config :json_rpc_api, JsonRpcApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xltJ17aHTVquJPksI/NFtxKELJUEUMkWmHAr8Chei/Xzw10kCf8pantifpki2H0y",
  render_errors: [view: JsonRpcApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: JsonRpcApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
