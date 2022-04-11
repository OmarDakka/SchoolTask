defmodule School.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Teachers.Teacher
  alias School.Students.Student

  @doc """
  Schema for the courses, with the fields specified, and a many to one relationship with the teachers and many to many
  relationship with the students.
  """
  @derive {Jason.Encoder, only: [:course_name, :code, :semester, :description, :teacher_id]}
  schema "courses" do
    field :course_name, :string
    field :code, :string
    field :semester, :string
    field :description, :string

    belongs_to :teacher, Teacher

    many_to_many :students, Student,
      join_through: "students_courses",
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end

  @doc """
  The changeset that the attributes go through to validate but they are handled in the repo.
  """
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:course_name, :code, :semester, :description, :teacher_id])
    |> foreign_key_constraint(:teacher_id)
    |> validate_required([:course_name, :code, :semester, :teacher_id])
  end
end
