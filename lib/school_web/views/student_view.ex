defmodule SchoolWeb.StudentView do
  use SchoolWeb, :view

  @doc """
  Render a paginated list of students
  """
  def render("index.json", %{students_results: students_results}) do
    %{
      students: students_results.entries,
      page_number: students_results.page_number,
      page_size: students_results.page_size,
      total_pages: students_results.total_pages,
      total_entries: students_results.total_entries
    }
  end

  @doc """
  Render the created student
  """
  def render("create.json", %{student: student}) do
    render_one(student, SchoolWeb.StudentView, "show.json")
  end

  @doc """
  Render the selected student
  """
  def render("show.json", %{student: student}) do
    %{
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      date_of_birth: student.date_of_birth
    }
  end

  @doc """
  Render the updated student
  """
  def render("update.json", %{student: student}) do
    render_one(student, SchoolWeb.StudentView, "show.json")
  end

  @doc """
  Render a success message after deleting an existing student
  """
  def render("delete.json", _) do
    %{status: "Student Deleted"}
  end

  @doc """
  Render the associated student with the course
  """
  def render("sign_up.json", %{course: course, student: student}) do
    %{
      Student: render_one(student, SchoolWeb.StudentView, "show.json"),
      Course: render_one(course, SchoolWeb.CourseView, "show.json")
    }
  end
end
