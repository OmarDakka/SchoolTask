defmodule SchoolWeb.TeacherController do
  use SchoolWeb, :controller

  alias School.Teachers

  @doc """
  Function that takes in a list of teachers then renders them as json output, they are
  also paginated with each page showing 4 entries.
  """
  def index(conn, params) do
    teacher_result = Teachers.list_teachers(params)

    render(conn, "index.json", teacher_result: teacher_result)
  end

  @doc """
  function that creates the new teacher, takes in the attributes from the params,
  hands them to the function responsible for delivering the attrs to the changeset to
  validate then returns the struct of the newly created teacher or an error, both rendered
  in json.
  """
  def create(conn, %{"teachers" => teacher_params}) do
    IO.inspect(teacher_params)

    case Teachers.create_teacher(teacher_params) do
      {:ok, teacher} ->
        render(conn, "create.json", teacher: teacher)

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
  function that takes in a teacher id from the params and returns a struct of a teacher if found, else it will
  return nil, both rendered in json.
  """
  def show(conn, %{"id" => id}) do
    case Teachers.get_teacher(id) do
      nil ->
        json(conn, "No teacher with that id")

      teacher ->
        render(conn, "show.json", teacher: teacher)
    end
  end

  @doc """
  Takes in the teacher id and preloads the courses associated with that teacher,
  then returns them to handle in json.
  """
  def show_multiple(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher_courses(id)
    render(conn, "show_courses.json", teacher: teacher)
  end

  @doc """
  Takes in the teacher id and loads the students that take the courses that the teacher
  is associated with.
  """
  def show_students(conn, %{"id" => id}) do
    students = Teachers.get_students(id)
    render(conn, "show_students.json", students: students)
  end

  @doc """
  Takes the teacher id then takes in attrs from params to
  update the teacher fields then return the struct or the error in json.
  """
  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Teachers.get_teacher(id)

    case Teachers.update_teacher(teacher, teacher_params) do
      {:ok, teacher} ->
        render(conn, "update.json", teacher: teacher)

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
  Takes the id for the teacher then deletes it from the database.
  """
  def delete(conn, %{"id" => id}) do
    teacher = Teachers.get_teacher(id)
    {:ok, _teacher} = Teachers.delete_teacher(teacher)
    render(conn, "delete.json")
  end
end
