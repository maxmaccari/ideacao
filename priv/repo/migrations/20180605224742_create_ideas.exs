defmodule Ideacao.Repo.Migrations.CreateIdeas do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :title, :string, null: false
      add :target, :string, null: false
      add :problem, :text, null: false
      add :description, :text, null: false
      add :author_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:ideas, [:author_id])
  end
end
