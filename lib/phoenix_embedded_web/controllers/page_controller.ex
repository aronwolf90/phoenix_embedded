defmodule PhoenixEmbeddedWeb.PageController do
  use PhoenixEmbeddedWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
