defmodule Ideacao.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Ideacao.Repo

  alias Ideacao.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates a user with it's passwords.

  ## Examples

      iex> update_user_registration(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user_registration(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_registration(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user registration changes.

  ## Examples

      iex> change_user_registration(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user_registration(%User{} = user) do
    User.registration_changeset(user, %{})
  end

  alias Comeonin.Bcrypt

  @doc """
  Authenticate a user by email and password.

  ## Examples

      iex> authenticate_user("example@example.com", "secret")
      {:ok, %User{}}

      iex> authenticate_user("example@example.com", "wrong")
      {:error, "Incorrect username or password"}

  """
  def authenticate_user(email, password) do
    query = from u in User, where: u.email == ^email

    Repo.one(query)
    |> check_password(password)
  end

  defp check_password(nil, _) do
    Bcrypt.dummy_checkpw()
    {:error, "Incorrect username or password"}
  end

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.encrypted_password) do
       true -> {:ok, user}
       false -> {:error, "Incorrect username or password"}
    end
  end
end
