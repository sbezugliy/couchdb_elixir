use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :emporium, Emporium.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :emporium, Emporium.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "pguser",
  password: "pgpass",
  database: "couchadmin_test",
  hostname: "localhost",
  pool_size: 10

config :couchdb_adapter,
  protocol:         "http",        # http or https
  hostname:         "172.17.0.2",  # IP address or hostname
  port:             "5984",        # main API port
  backend_port:     "5986",        # port used in backend transactions, configuring nodes and access to system databases

  database:         "couchdb_test",     # database name

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
