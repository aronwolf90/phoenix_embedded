defmodule PhoenixEmbeddedWeb.Router do
  use PhoenixEmbeddedWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixEmbeddedWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :widget do
    plug CORSPlug, origin: ["http://localhost:8080", "https://getbootstrap.com"]
    plug :put_root_layout, html: {PhoenixEmbeddedWeb.Layouts, :widget}

    # Only needed if the parent domain is different for WP and phoenix.
    # I recommend to set it same_site to Lax on production.
    plug Plug.Session,
      store: :cookie,
      key: "_phoenix_embedded_key",
      signing_salt: "7kAtqfMo",
      same_site: "None; Secure"
  end

  scope "/widget", PhoenixEmbeddedWeb do
    pipe_through [:browser, :widget]

    live_session :widget, layout: false do
      live "/questionnaire", QuestionnaireLive
    end
  end

  scope "/", PhoenixEmbeddedWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixEmbeddedWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenix_embedded, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixEmbeddedWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
