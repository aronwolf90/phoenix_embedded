defmodule PhoenixEmbedded.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_embedded,
    adapter: Ecto.Adapters.SQLite3
end
