defmodule SchoolWeb.CourseView do
  use SchoolWeb, :view

  @doc """
  Renders a list of courses.
  """
  def render("index.json", %{data: data}) do
    %{entries: course, metadata: metadata} = data

    %{
      entries: render_many(course, SchoolWeb.CourseView, "course.json"),
      metadata: %{
        after: metadata.after,
        before: metadata.before,
        total_count: metadata.total_count
      }
    }
  end

  @doc """
  Renders the newly created course.
  """
  def render("create.json", %{course: course}) do
    %{data: render_one(course, SchoolWeb.CourseView, "course.json")}
  end

  @doc """
  Renders the chosen course based on handed id.
  """
  def render("show.json", %{course: course}) do
    %{data: render_one(course, SchoolWeb.CourseView, "course.json")}
  end

  @doc """
  Renders the students that take the course.
  """
  def render("course_students.json", %{course: course}) do
    %{data: render_many(course.students, SchoolWeb.StudentView, "show.json")}
  end

  @doc """
  Renders the updated course.
  """
  def render("update.json", %{course: course}) do
    render_one(course, SchoolWeb.CourseView, "course.json")
  end

  @doc """
  Renders a response confirming the course was deleted
  """
  def render("delete.json", _) do
    %{status: "Course Deleted"}
  end

  def render("course.json", %{course: course}) do
    %{
      id: course.id,
      course_name: course.course_name,
      code: course.code,
      teacher_id: course.teacher_id,
      description: course.description,
      semester: course.semester
    }
  end
end
