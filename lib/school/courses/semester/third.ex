defmodule School.Courses.Semester.Third do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @derive {Jason.Encoder, only: [:period, :is_honor, :is_research]}
  embedded_schema do
    field :period, :string
    field :is_honor, :boolean
    field :is_research, :boolean
  end

  def changeset(third, params) do
    third
    |> cast(params, [:period, :is_honor, :is_research])
    |> validate_required([:period, :is_honor, :is_research])
  end
end
