defmodule Ideacao.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
