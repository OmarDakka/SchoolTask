defmodule SchoolWeb.ProtocolController do
  use SchoolWeb, :controller
  alias School.Students
  alias School.Teachers
  alias School.Person

  def show_student(conn, %{"id" => id}) do
    case Students.get_student(id) do
      nil ->
        conn
        |> put_status(404)
        |> json("resource not found")

      student ->
        person = Person.show(student)
        render(conn, "show.json", person: person)
    end
  end

  def show_teacher(conn, %{"id" => id}) do
    case Teachers.get_teacher(id) do
      nil ->
        conn
        |> put_status(404)
        |> json("resource not found")

      teacher ->
        person = Person.show(teacher)
        render(conn, "show.json", person: person)
    end
  end
end
