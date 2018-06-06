defmodule Ideacao.Ideas.Feedback do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Ideacao.Ideas.{Idea, Feedback}


  schema "feedbacks" do
    field :comment, :string
    field :rate, :integer
    belongs_to :user, Ideacao.Accounts.User
    belongs_to :idea, Idea

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:rate, :comment, :user_id, :idea_id])
    |> validate_required([:user_id, :idea_id])
    |> validate_inclusion(:rate, 0..10)
  end

  def by_idea(idea = %Idea{}) do
    from f in Feedback, where: f.idea_id == ^idea.id
  end
end
