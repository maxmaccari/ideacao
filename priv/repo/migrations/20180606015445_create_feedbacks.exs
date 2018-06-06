defmodule Ideacao.Repo.Migrations.CreateFeedbacks do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :rate, :integer, default: 0
      add :comment, :text, default: ""
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :idea_id, references(:ideas, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:feedbacks, [:user_id])
    create index(:feedbacks, [:idea_id])
  end
end
