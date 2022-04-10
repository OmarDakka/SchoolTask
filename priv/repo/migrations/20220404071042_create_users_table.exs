defmodule School.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, min: 8, max: 16
      add :password, :string, null: false, min: 8

      timestamps()
    end
  end
end
