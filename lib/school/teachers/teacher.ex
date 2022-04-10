defmodule School.Teachers.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Courses.Course
  @doc """
  The schema for the `teachers` table.
  """
  @derive {Jason.Encoder, only: [:first_name, :last_name, :email]}
  schema "teachers" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    has_many :courses, Course

    timestamps()
  end

  @doc """
  Teacher changeset that the values go through to validate the attributes
  """
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name])
    |> validate_email()
  end

  @doc """
  email validation, checks for regular expression, length and it has to be unique
  """
  def validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, School.Repo)
  end
end
