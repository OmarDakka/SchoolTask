defmodule School.Courses do
  import Ecto.Query, warn: false
  alias School.Repo
  alias School.Courses.Course

  @doc """
  Query that returns a list of all the courses.
  """
  def list_courses(params) do
    query = from(c in Course, order_by: [asc: c.inserted_at, asc: c.id])

    %{entries: entries, metadata: metadata} =
      Repo.paginate(
        query,
        after: params["after"],
        before: params["before"],
        cursor_fields: [:inserted_at, :id],
        include_total_count: true,
        limit: 4
      )

    %{entries: entries, metadata: metadata}
  end

  @doc """
  Query that takes in a course id and returns it.
  """
  def get_course(id) do
    Course
    |> Repo.get(id)
    |> Repo.preload(:students)
  end

  @doc """
  Takes in the attributes and passes them to the changeset to create a new course.
  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Takes in the attributes to update fields in the course and passes them to the changeset to validate.
  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Query to delete a course off the database.
  """
  def delete_course(%Course{} = course) do
    course
    |> Repo.delete()
  end
end
