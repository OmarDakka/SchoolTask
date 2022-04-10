defmodule School.Repo.Migrations.CreateStudentsTable do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :first_name, :string, null: false
      add :email, :string, null: false, size: 160
      add :date_of_birth, :date, null: false
      add :last_name, :string

      timestamps()
    end
  end
end
