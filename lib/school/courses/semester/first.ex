defmodule School.Courses.Semester.First do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :period, :string
    field :is_optional, :boolean
  end

  def changeset(first, attrs) do
    first
    |> cast(attrs, [:period, :is_optional])
    |> validate_required([:period, :is_optional])
  end
end