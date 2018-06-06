defmodule Ideacao.Ideas.Feedback do
  use Ecto.Schema
  import Ecto.Changeset


  schema "feedbacks" do
    field :comment, :string
    field :rate, :integer
    belongs_to :user, Ideacao.Accounts.User
    belongs_to :idea, Ideacao.Ideas.Idea

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:rate, :comment, :user_id, :idea_id])
    |> validate_required([:user_id, :idea_id])
    |> validate_inclusion(:rate, 0..10)
  end
end
