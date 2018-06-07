defmodule Ideacao.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :name, :string
    has_many :ideas, Ideacao.Ideas.Idea, foreign_key: :author_id
    has_many :feedbacks, Ideacao.Ideas.Feedback

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/)
    |> unique_constraint(:email)
  end

  @doc false
  def password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

  @doc false
  def registration_changeset(user, attrs) do
    changeset(user, attrs)
    |> password_changeset(attrs)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
