# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ideacao,
  ecto_repos: [Ideacao.Repo]

# Configures the endpoint
config :ideacao, IdeacaoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3jHddNjHYJW+HGq4TtmMi61OHFxBCbpkaXXKDXQhqZK69K0p7ORYrLzWmcP74Ypl",
  render_errors: [view: IdeacaoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ideacao.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :ideacao, IdeacaoWeb.Auth.Guardian,
  issuer: "ideacao",
  secret_key: "lL3bQVEa6U0vpL/uGqlw2xyIVnPJQ4I3Q4nfQ8HizZAHN28WE/II+tOk3GooyB2g"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
