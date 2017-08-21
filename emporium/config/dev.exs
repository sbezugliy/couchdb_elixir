use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :emporium, Emporium.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :emporium, Emporium.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :emporium, Emporium.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pguser",
  password: "pgpass",
  database: "couchadmin_dev",
  hostname: "localhost",
  pool_size: 10

config :couchdb_adapter,
  protocol:         "http",        # http or https
  hostname:         "172.17.0.2",  # IP address or hostname
  port:             "5984",        # main API port
  backend_port:     "5986",        # port used in backend transactions, configuring nodes and access to system databases

  database:         "couchdb_dev",     # database name

  # Authentication types. Possible: :party, :basic, :cookie, :oauth
  auth_type:        :cookie,

  ### :basic_auth, :cookie_auth
  # Allowed API entry points depends to right of user, used in transactions
  username:         "admin",
  password:         "supersecret",

  ### :oauth
  # OAuth 1.0 credentials
  consumer_key:     "6ab4ddd1ce65f6381cef17e0fbfefd66757440488530275fc085b51edb06f834",
  consumer_secret:  "a723486eaaac5906a834b19881961a36865f43aa560b8d5877ace1d771e6ddd4",
  token:            "f4e4ef1e10be83fa872c24cd52f116671c9da29dc54273caa2b22190d2df9712",
  token_secret:     "d45c84d26c56af1e02ea20e400c4f78e90c3caa1f9600e20199f8418112b9260"
