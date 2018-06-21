defmodule Ideacao.Ideas.Idea do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ideas" do
    field :description, :string
    field :title, :string
    field :problem, :string
    field :target, :string
    belongs_to :author, Ideacao.Accounts.User
    has_many :feedbacks, Ideacao.Ideas.Feedback

    timestamps()
  end

  @doc false
  def changeset(idea, attrs) do
    idea
    |> cast(attrs, [:title, :target, :problem, :description, :author_id])
    |> validate_required([:title, :target, :problem, :description, :author_id])
  end
end
