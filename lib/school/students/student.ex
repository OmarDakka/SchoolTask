defmodule School.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Courses.Course

  @doc """
  Schema for students table with the appropriate fields, and it has a many to many relationship with the courses table. joining through
  the `students_courses` table
  """
  @derive {Jason.Encoder, only: [:first_name, :last_name, :email, :date_of_birth]}
  schema "students" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :date_of_birth, :date

    many_to_many :courses, Course,
      join_through: "students_courses",
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end

  @doc """
  The changeset validators that make sure that the data fit the schema needs
  """
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name, :email, :date_of_birth])
    |> validate_required([:first_name, :date_of_birth])
    |> validate_email()
  end

  @doc """
  Email validation in order to enter a valid email using regular expression
  """
  def validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, School.Repo)
  end
end
