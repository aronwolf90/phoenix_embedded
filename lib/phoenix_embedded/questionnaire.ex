defmodule PhoenixEmbedded.Questionnaire do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :field1, :string
    field :field2, :date
  end

  def changeset(form, attrs) do
    form
    |> cast(attrs, [:field1, :field2])
  end
end
