defmodule School.Students do
  import Ecto.Query, warn: false
  alias School.Repo

  alias School.Students.Student

  def list_students(params) do
    Student
    |> Repo.paginate(params)
  end

  def get_student(id) do
    Student
    |> Repo.get(id)
    |> case do
      nil -> nil
      student -> Repo.preload(student, :courses)
    end
  end

  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  def delete_student(%Student{} = student) do
    student
    |> Repo.delete()
  end
end
