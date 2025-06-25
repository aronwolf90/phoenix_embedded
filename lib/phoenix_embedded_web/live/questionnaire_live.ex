defmodule PhoenixEmbeddedWeb.QuestionnaireLive do
  use PhoenixEmbeddedWeb, :live_view_widget

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-red-100 text-black">
      <.button phx-click="test">Click me</.button>
      {assigns[:test_text]}
    </div>
    """
  end

  def handle_event("test", _, socket) do
    {:noreply, assign(socket, :test_text, "Button clicked")}
  end
end
