defmodule SchoolWeb.StudentView do
  use SchoolWeb, :view

  @doc """
  Render a paginated list of students
  """
  def render("index.json", %{students_results: students_results}) do
    %{entries: student, metadata: metadata} = students_results

    %{
      entries: render_many(student, SchoolWeb.StudentView, "student.json"),
      metadata: %{
        after: metadata.after,
        before: metadata.before,
        total_count: metadata.total_count
      }
    }
  end

  @doc """
  Render the created student
  """
  def render("create.json", %{student: student}) do
    render_one(student, SchoolWeb.StudentView, "student.json")
  end

  @doc """
  Render the selected student
  """
  def render("show.json", %{student: student}) do
    render_one(student, SchoolWeb.StudentView, "student.json")
  end

  def render("student.json", %{student: student}) do
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
    render_one(student, SchoolWeb.StudentView, "student.json")
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
