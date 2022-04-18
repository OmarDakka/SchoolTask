defmodule School.Repo.Migrations.AddFieldsToStudent do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :gender, :string, null: false
      add :address, :string, null: false
    end
  end
end
