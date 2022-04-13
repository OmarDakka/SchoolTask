defmodule School.Courses.Semester.Fourth do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :period, :string
    field :is_honor, :boolean
    field :is_research, :boolean
  end

  def changeset(fourth, params) do
    fourth
    |> cast(params, [:period, :is_honor, :is_research])
    |> validate_required([:period, :is_honor, :is_research])
  end
end
