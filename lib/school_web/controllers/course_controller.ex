defmodule SchoolWeb.CourseController do
  use SchoolWeb, :controller

  alias School.Repo
  alias School.Courses

  @doc """
  Takes in a list of courses and paginates them showing 4 entries at a time, and returns them as json.
  """
  def index(conn, params) do
    course_result = Courses.list_courses(params)

    render(conn, "index.json", course_result: course_result)
  end

  @doc """
  Takes in course attributes from params and passes them to the changeset to validate,
  if a course is created, its returned in json, else an error will be rendered in json
  """
  def create(conn, %{"course" => course_params}) do
    case Courses.create_course(course_params) do
      {:ok, course} ->
        render(conn, "create.json", course: course)

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
  Takes in a course id and returns the course struct in json, or renders and error
  in json if a course was not found.
  """
  def show(conn, %{"id" => id}) do
    case Courses.get_course(id) do
      nil ->
        json(conn, "No course with that id")

      course ->
        render(conn, "show.json", course: course)
    end
  end

  @doc """
  Takes a course id and returns the course with the students associated with it.
  """
  def get_course_students(conn, %{"id" => id}) do
    course = Courses.get_course(id) |> Repo.preload(:students)
    render(conn, "course_students.json", course: course)
  end

  @doc """
  Takes a course id and course attributes from params, find the course and updates the
  desired fields, returns the updated course or error in json.
  """
  def update(conn, %{"id" => id, "course" => course_params}) do
    course = Courses.get_course(id)

    case Courses.update_course(course, course_params) do
      {:ok, course} ->
        render(conn, "update.json", course: course)

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
  Takes the course id and deletes it off the database.
  """
  def delete(conn, %{"id" => id}) do
    course = Courses.get_course(id)
    {:ok, _course} = Courses.delete_course(course)
    render(conn, "delete.json")
  end
end
