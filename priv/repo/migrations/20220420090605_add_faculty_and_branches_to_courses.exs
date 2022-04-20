defmodule School.Repo.Migrations.AddFacultyAndBranchesToCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :faculty, :string, null: false
      add :branches, :string
    end
  end
end
