defmodule SchoolWeb.StudentView do
  use SchoolWeb, :view

  def render("index.json", %{students_results: students_results}) do
    %{
      students: students_results.entries,
      page_number: students_results.page_number,
      page_size: students_results.page_size,
      total_pages: students_results.total_pages,
      total_entries: students_results.total_entries
    }
  end

  def render("create.json", %{student: student}) do
    %{
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      date_of_birth: student.date_of_birth
    }
  end

  def render("show.json", %{student: student}) do
    %{
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      date_of_birth: student.date_of_birth
    }
  end

  def render("update.json", %{student: student}) do
    %{
      id: student.id,
      first_name: student.first_name,
      last_name: student.last_name,
      email: student.email,
      date_of_birth: student.date_of_birth
    }
  end

  def render("delete.json", _) do
    %{status: "Student Deleted"}
  end

  def render("sign_up.json", %{course: course}) do
    %{status: "ok", course: course}
  end
end
