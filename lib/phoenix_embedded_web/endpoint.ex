defmodule PhoenixEmbeddedWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phoenix_embedded

  @session_options [
    store: :cookie,
    key: "_phoenix_embedded_key",
    signing_salt: "7kAtqfMo",
    # Only needed if the parent domain is different for WP and phoenix.
    # I recommend to set it same_site to Lax on production.
    #
    # TODO: Add condition for Safary and move it into the widget pipe.
    same_site: "None; Secure"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :phoenix_embedded,
    gzip: false,
    only: PhoenixEmbeddedWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :phoenix_embedded
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug PhoenixEmbeddedWeb.Router
end
