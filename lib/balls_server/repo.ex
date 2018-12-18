defmodule BallsServer.Repo do
  use Ecto.Repo,
    otp_app: :balls_server,
    adapter: Ecto.Adapters.Postgres
end
