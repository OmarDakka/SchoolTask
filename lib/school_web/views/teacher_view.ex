defmodule SchoolWeb.TeacherView do
  use SchoolWeb, :view

  @doc """
  renders the list of teachers
  """
  def render("index.json", %{teacher_result: teacher_result}) do
    %{
      teachers: teacher_result.entries,
      page_number: teacher_result.page_number,
      page_size: teacher_result.page_size,
      total_pages: teacher_result.total_pages,
      total_entries: teacher_result.total_entries
    }
  end

  @doc """
  Renders the newly created teacher
  """
  def render("create.json", %{teacher: teacher}) do
    render_one(teacher, SchoolWeb.TeacherView, "show.json")
  end

  @doc """
  Renders one teacher based on id
  """
  def render("show.json", %{teacher: teacher}) do
    %{
      id: teacher.id,
      first_name: teacher.first_name,
      last_name: teacher.last_name,
      email: teacher.email
    }
  end

  @doc """
  Renders the updated teacher
  """
  def render("update.json", %{teacher: teacher}) do
    render_one(teacher, SchoolWeb.TeacherView, "show.json")
  end

  @doc """
  Returns the status that indicate that the teacher was deleted.
  """
  def render("delete.json", _) do
    %{status: "Teacher deleted"}
  end

  @doc """
  Returns the courses associated with the teacher
  """
  def render("show_courses.json", %{teacher: teacher}) do
    %{
      Teacher: render_one(teacher, SchoolWeb.TeacherView, "show.json"),
      Courses: render_many(teacher.courses, SchoolWeb.CourseView, "show.json")
    }
  end

  @doc """
  Renders the students that take the courses associated with the specified teacher.
  """
  def render("show_students.json", %{students: students}) do
    render_many(students, SchoolWeb.StudentView, "show.json")
  end

  @doc """
  Render the newly created teacher and newly created course
  """
  def render("create_teacher_and_course.json", %{result: result}) do
    %{
      Teacher: render_one(result.teacher, SchoolWeb.TeacherView, "show.json"),
      Course: render_one(result, SchoolWeb.CourseView, "show.json")
    }
  end
end
