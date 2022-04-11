defmodule School.Students do
  import Ecto.Query, warn: false
  alias School.Repo

  alias School.Students.Student

  @doc """
  Query for showing all the student records on the table and paginate them accordingly
  """
  def list_students(params) do
    Student
    |> Repo.paginate(params)
  end

  @doc """
  Query to show one entry for a student
  """
  def get_student(id) do
    Student
    |> Repo.get(id)
    |> case do
      nil -> nil
      student -> Repo.preload(student, :courses)
    end
  end

  @doc """
  Function to pass in attributes for new student row, then insert it in the database
  """
  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Function to pass in attributes for an existing student to update
  """
  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Function to delete an existing student row off of the database
  """
  def delete_student(%Student{} = student) do
    student
    |> Repo.delete()
  end
end
