defmodule SchoolWeb.CourseView do
  use SchoolWeb, :view

  @doc """
  Renders a list of courses.
  """
  def render("index.json", %{course_result: course_result}) do
    %{
      courses: course_result.entries,
      page_number: course_result.page_number,
      page_size: course_result.page_size,
      total_pages: course_result.total_pages,
      total_entries: course_result.total_entries
    }
  end

  @doc """
  Renders the newly created course.
  """
  def render("create.json", %{course: course}) do
    render_one(course, SchoolWeb.CourseView, "show.json")
  end

  @doc """
  Renders the chosen course based on handed id.
  """
  def render("show.json", %{course: course}) do
    %{
      id: course.id,
      course_name: course.course_name,
      code: course.code,
      teacher_id: course.teacher_id,
      description: course.description,
      semester: course.semester
    }
  end

  @doc """
  Renders the students that take the course.
  """
  def render("course_students.json", %{course: course}) do
    render_many(course.students, SchoolWeb.StudentView, "show.json")
  end

  @doc """
  Renders the updated course.
  """
  def render("update.json", %{course: course}) do
    render_one(course, SchoolWeb.CourseView, "show.json")
  end

  @doc """
  Renders a response confirming the course was deleted
  """
  def render("delete.json", _) do
    %{status: "Course Deleted"}
  end
end
