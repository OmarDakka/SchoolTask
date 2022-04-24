defmodule School.Repo.Migrations.AddFieldsToTeacher do
  use Ecto.Migration

  def change do
    alter table(:teachers) do
      add :gender, :string, null: false
      add :address, :string, null: false
      add :date_of_birth, :date, null: false
    end
  end
end
