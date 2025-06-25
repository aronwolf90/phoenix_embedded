defmodule PhoenixEmbeddedWeb.QuestionnaireLive do
  use PhoenixEmbeddedWeb, :live_view_widget

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-red-100">
      -----Widget------
    </div>
    """
  end
end
