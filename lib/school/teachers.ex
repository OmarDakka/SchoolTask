defmodule School.Teachers do
  import Ecto.Query, warn: false
  alias School.Repo

  alias School.Teachers.Teacher
  alias School.Teachers
  alias School.Courses
  alias School.Courses.Course

  @doc """
  Query to get a list of all the teachers in database.
  """
  @spec list_teachers(keyword | map) :: Scrivener.Page.t()
  def list_teachers(params) do
    Teacher
    |> Repo.paginate(params)
  end

  @doc """
  Query to get one teacher from database using the teacher id.
  """
  @spec get_teacher(any) :: any
  def get_teacher(id) do
    Teacher
    |> Repo.get(id)
  end

  @doc """
  Query to get the courses that are associated with a teacher based on the teacher's id.
  """
  @spec get_teacher_courses(any) :: nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  def get_teacher_courses(id) do
    Teacher
    |> Repo.get(id)
    |> Repo.preload(:courses)
  end

  @doc """
  Query to get the students that the teacher's courses are associated with.
  """
  @spec get_students(any) :: list
  def get_students(id) do
    Course
    |> Repo.all(teacher_id: id)
    |> Repo.preload(:students)
    |> Enum.map(fn course -> course.students end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn student, acc ->
      Map.put(acc, student.id, student)
    end)
    |> Map.values()
  end

  @doc """
  Function responsible for creating a new teacher, attributes go through the
  changeset for validation then its inserted in the database.
  """
  @spec create_teacher(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def create_teacher(attrs \\ %{}) do
    %Teacher{}
    |> Teacher.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Query transaction that creates a teacher first passing in the params, then creates
  a course passing in the id of the newly created teacher
  """
  @spec create_teacher_and_course(any) :: any
  def create_teacher_and_course(attrs) do
    Repo.transaction(fn ->
      {:ok, teacher} = Teachers.create_teacher(attrs)
      attrs = Map.put(attrs, "teacher_id", teacher.id)
      Courses.create_course(attrs)
    end)
  end

  @doc """
  Function for updating fields in the teacher, it goes through the changeset for validation then updated
  in the database.
  """

  def update_teacher(%Teacher{} = teacher, attrs) do
    teacher
    |> Teacher.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Function responsible for deleting an instance of a teacher in the database.
  """
  def delete_teacher(%Teacher{} = teacher) do
    teacher
    |> Repo.delete()
  end
end
