defmodule PhoenixEmbeddedWeb.QuestionnaireLive do
  use PhoenixEmbeddedWeb, :live_view_widget

  alias PhoenixEmbedded.Questionnaire

  @impl true
  def mount(_params, _session, socket) do
    form = to_form(Questionnaire.changeset(%Questionnaire{}, %{}))

    {:ok, assign(socket, form: form, current_page: "first")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.simple_form
      id="questionnaire"
      for={@form}
      phx-change="validate"
      phx-submit="submit"
      class=""
    >
      <input type="hidden" name="current_page" value={@current_page} />

      <.page page="first" current_page={@current_page} >
        <.input field={@form[:first]} label="First" />

        <.button class="mt-4">Next</.button>
      </.page>

      <.page page="second" current_page={@current_page} >
        <.input field={@form[:second]} />

        <.button class="mt-4">Submit</.button>
      </.page>

      <.page page="success" current_page={@current_page} >
        You have successfully submitted the form!
        <p><span class="font-bold">first:</span> {@form[:first].value}</p>
        <p><span class="font-bold">second:</span> {@form[:second].value}</p>
      </.page>
    </.simple_form>
    """
  end

  def page(assigns) do
    ~H"""
    <span class={[@page != @current_page && "hidden"]}>
      {render_slot(@inner_block)}
    </span>
    """
  end

  def handle_event(
    "validate",
    %{
      "current_page" => current_page,
      "questionnaire" => questionnaire
    },
    socket
  ) do
    form =
      %Questionnaire{}
      |> Questionnaire.changeset(questionnaire)
      |> to_form()

    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("submit", _, socket) do
    case socket.assigns.current_page do
      "first" ->
         {:noreply, assign(socket, :current_page, "second")}
      "second" ->
         {:noreply, assign(socket, :current_page, "success")}
    end
  end
end
