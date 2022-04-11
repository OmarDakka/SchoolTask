defmodule SchoolWeb.StudentController do
  use SchoolWeb, :controller

  import Ecto.Changeset

  alias School.Repo
  alias School.Students
  alias School.Courses

  @doc """
  Listing all student rows
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, params) do
    students_results = Students.list_students(params)

    render(conn, "index.json", students_results: students_results)
  end

  @doc """
  Creating a new student, passing in the params
  """
  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"students" => student_params}) do
    case Students.create_student(student_params) do
      {:ok, student} ->
        render(conn, "create.json", student: student)

      {:error, error} ->
        json(
          conn,
          Enum.map(error.errors, fn message ->
            {
              field,
              {text, validation}
            } = message

            "field #{field}: #{text} #{inspect(validation)}"
          end)
        )
    end
  end

  @doc """
  Function to assign an existing course to an existing student, using the many to many relationship
  """
  @spec sign_up(Plug.Conn.t(), map) :: Plug.Conn.t()
  def sign_up(conn, %{"student_id" => student_id, "course_id" => course_id}) do
    student = Students.get_student(student_id)
    course = Courses.get_course(course_id)

    students_loaded = Repo.preload(course, :students)
    students_changeset = Ecto.Changeset.change(students_loaded)

    student_course_changeset =
      students_changeset |> put_assoc(:students, [student | students_loaded.students])

    Repo.update(student_course_changeset)

    render(conn, "sign_up.json", course: course, student: student)
  end

  @doc """
  Retreive a single specified student info based on passed id
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    case Students.get_student(id) do
      nil ->
        json(conn, "No student with that id")

      student ->
        render(conn, "show.json", student: student)
    end
  end

  @doc """
  Update an existing student based on the passed id and the params
  """
  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Students.get_student(id)

    case Students.update_student(student, student_params) do
      {:ok, student} ->
        render(conn, "update.json", student: student)

      {:error, error} ->
        json(
          conn,
          Enum.map(error.errors, fn message ->
            {
              field,
              {text, validation}
            } = message

            "field #{field}: #{text} #{inspect(validation)}"
          end)
        )
    end
  end

  @doc """
  Delete an existing record of a student
  """
  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    student = Students.get_student(id)
    {:ok, _student} = Students.delete_student(student)
    render(conn, "delete.json")
  end
end
