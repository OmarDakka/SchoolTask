import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :school, School.Repo,
  username: "root",
  password: "2BzM7gH0",
  hostname: "localhost",
  database: "school_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :school, SchoolWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yV2iaOF06UUUS+DcXxOtU+AAxC1OAV2JbVOwM0Hc+9VNovHdcZygeIRKMqBUmBn8",
  server: false

# In test we don't send emails.
config :school, School.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
