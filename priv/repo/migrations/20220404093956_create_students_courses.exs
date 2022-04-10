defmodule School.Repo.Migrations.CreateStudentsCourses do
  use Ecto.Migration

  def change do
    create table(:students_courses) do
      add :student_id, references(:students)
      add :course_id, references(:courses)
    end

    create unique_index(:students_courses, [:student_id, :course_id])
  end
end
