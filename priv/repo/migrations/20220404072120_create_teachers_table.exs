defmodule School.Repo.Migrations.CreateTeachersTable do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :first_name, :string, null: false
      add :email, :string, null: false, size: 160
      add :last_name, :string

      timestamps()
    end
  end
end
