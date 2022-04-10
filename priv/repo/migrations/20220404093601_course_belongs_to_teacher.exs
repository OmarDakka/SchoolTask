defmodule School.Repo.Migrations.CourseBelongsToTeacher do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :teacher_id, references(:teachers, on_delete: :nilify_all)
    end
  end
end
