defmodule School.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Courses.Course
  @fields [:first_name, :last_name, :email, :date_of_birth, :gender, :address]
  @required_fields [:first_name, :date_of_birth, :gender, :address]
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
    field :gender, :string
    field :address, :string

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
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
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
