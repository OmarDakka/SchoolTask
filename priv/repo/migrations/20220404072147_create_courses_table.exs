defmodule School.Repo.Migrations.CreateCoursesTable do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :course_name, :string, null: false
      add :code, :string, null: false
      add :semester, :string, null: false
      add :description, :text
      add :metadata, :map, null: false

      timestamps()
    end
  end
end
