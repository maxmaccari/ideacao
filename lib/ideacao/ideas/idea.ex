defmodule Ideacao.Ideas.Idea do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ideas" do
    field :description, :string
    field :name, :string
    field :problem, :string
    field :target, :string
    belongs_to :author, Ideacao.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(idea, attrs) do
    idea
    |> cast(attrs, [:name, :target, :problem, :description, :author_id])
    |> validate_required([:name, :target, :problem, :description, :author_id])
  end
end
