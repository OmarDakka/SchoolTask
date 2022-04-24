defmodule School.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias School.Teachers.Teacher
  alias School.Students.Student
  alias School.Courses.Semester.{First, Second, Third, Fourth}

  import PolymorphicEmbed, only: [cast_polymorphic_embed: 3]

  @type t :: %__MODULE__{
          course_name: String.t(),
          code: String.t(),
          semester: :first | :second | :third | :fourth,
          description: String.t(),
          metadata:
            First.t()
            | Second.t()
            | Third.t()
            | Fourth.t()
        }

  @course_fields [
    :course_name,
    :code,
    :semester,
    :description,
    :teacher_id,
    :faculty
  ]

  @required_fields [:course_name, :code, :teacher_id, :semester, :faculty]

  @engineering_branches [
    "civil",
    "chemical",
    "mechanical",
    "electrical",
    "industrial",
    "computer"
  ]

  @art_branches [
    "creative arts",
    "writing",
    "philosophy",
    "humanities"
  ]

  @science_branches [
    "physics",
    "biology",
    "chemistry",
    "math",
    "anatomy",
    "statistics"
  ]
  @doc """
  Schema for the courses, with the fields specified, and a many to one relationship with the teachers and many to many
  relationship with the students.
  """
  @derive {Jason.Encoder,
           only: [:course_name, :code, :semester, :description, :teacher_id, :metadata]}
  schema "courses" do
    field :course_name, :string
    field :code, :string
    field :semester, Ecto.Enum, values: [:first, :second, :third, :fourth], null: false
    field :description, :string
    field :faculty, Ecto.Enum, values: [:history, :engineering, :art, :science, :law]
    field :branches, :string

    field :metadata, PolymorphicEmbed,
      types: [
        first: First,
        second: Second,
        third: Third,
        fourth: Fourth
      ],
      on_type_not_found: :changeset_error,
      on_replace: :update

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
    attrs =
      case attrs["semester"] do
        nil -> attrs
        _ -> add_type_to_metadata(attrs)
      end

    course
    |> cast(attrs, @course_fields)
    |> validate_required(@required_fields)
    |> maybe_cast_branch(attrs)
    |> cast_polymorphic_embed(:metadata, required: true)
    |> foreign_key_constraint(:teacher_id)
    |> IO.inspect()
  end

  def add_type_to_metadata(%{"semester" => semester, "metadata" => metadata} = attrs)
      when is_map(metadata) do
    metadata = Map.merge(metadata, %{"__type__" => semester})

    Map.put(attrs, "metadata", metadata)
  end

  def maybe_cast_branch(changeset, attrs) do
    case get_field(changeset, :faculty) do
      :engineering ->
        changeset
        |> cast(attrs, [:branches])
        |> validate_inclusion(:branches, @engineering_branches)
        |> validate_required(:branches, message: "Please enter an engineering faculty branch")

      :art ->
        changeset
        |> cast(attrs, [:branches])
        |> validate_inclusion(:branches, @art_branches)
        |> validate_required(:branches, message: "Please enter an art faculty branch")

      :science ->
        changeset
        |> cast(attrs, [:branches])
        |> validate_inclusion(:branches, @science_branches)
        |> validate_required(:branches, message: "Please enter a science faculty branch")

      _ ->
        changeset
    end
  end
end
