defmodule Ideacao.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string
    has_many :ideas, Ideacao.Ideas.Idea, foreign_key: :author_id
    has_many :feedbacks, Ideacao.Ideas.Feedback

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :encrypted_password])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end
