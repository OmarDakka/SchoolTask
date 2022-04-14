defmodule School.Courses.Semester.Second do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @derive {Jason.Encoder, only: [:period, :is_optional]}
  embedded_schema do
    field :period, :string
    field :is_optional, :boolean
  end

  def changeset(second, params) do
    second
    |> cast(params, [:period, :is_optional])
    |> validate_required([:period, :is_optional])
  end
end
