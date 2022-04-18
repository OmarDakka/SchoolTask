defmodule SchoolWeb.ProtocolController do
  use SchoolWeb, :controller
  alias School.Students
  alias School.Teachers

  def show_student(conn, %{"id" => id}) do
    case Students.get_student(id) do
      nil ->
        json(conn, "No student with that id")

      student ->
        render(conn, "show.json", student: student)
    end
  end

  def show_teacher(conn, %{"id" => id}) do
    case Teachers.get_teacher(id) do
      nil ->
        json(conn, "No teacher with that id")

      teacher ->
        render(conn, "show.json", teacher: teacher)
    end
  end
end
