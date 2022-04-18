defmodule SchoolWeb.ProtocolController do
  use SchoolWeb, :controller
  alias School.Students
  alias School.Teachers
  alias School.Person

  def show_student(conn, %{"id" => id}) do
    case Students.get_student(id) do
      nil ->
        json(conn, "No student with that id")

      student ->
        number_of_courses = Person.show(student)
        render(conn, "show.json", data: %{person: student, number_of_courses: number_of_courses})
    end
  end

  def show_teacher(conn, %{"id" => id}) do
    case Teachers.get_teacher(id) do
      nil ->
        json(conn, "No teacher with that id")

      teacher ->
        number_of_courses = Person.show(teacher)
        render(conn, "show.json", data: %{person: teacher, number_of_courses: number_of_courses})
    end
  end
end
