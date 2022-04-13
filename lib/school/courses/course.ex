defmodule School.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset
  import PolymorphicEmbed, only: [cast_polymorphic_embed: 3]

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

    field :semester, PolymorphicEmbed,
      types: [
        first: School.Courses.Semester.First,
        second: School.Courses.Semester.Second,
        third: School.Courses.Semester.Third,
        fourth: School.Courses.Semester.Fourth
      ],
      on_replace: :update

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
    |> cast(attrs, [:course_name, :code, :description, :teacher_id])
    |> cast_polymorphic_embed(:semester, required: false)
    |> foreign_key_constraint(:teacher_id)
    |> validate_required([:course_name, :code, :teacher_id])
    |> IO.inspect()
  end
end
