# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :balls_server,
  ecto_repos: [BallsServer.Repo]

# Configures the endpoint
config :balls_server, BallsServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J8atz8q0o1ycpvLdbWexYqLeEJmXgmhbw8t8a42H0jXf3GVoOszroj6ZpR16DIvB",
  render_errors: [view: BallsServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BallsServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
