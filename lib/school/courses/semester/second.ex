defmodule School.Courses.Semester.Second do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :period, :string
    field :confirmed, :boolean
  end

  def changeset(second, params) do
    second
    |> cast(params, [:period, :confirmed])
    |> validate_required([:period, :confirmed])
  end
end
