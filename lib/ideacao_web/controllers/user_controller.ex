defmodule IdeacaoWeb.UserController do
  use IdeacaoWeb, :controller

  alias Ideacao.Accounts
  alias Ideacao.Accounts.User

  action_fallback IdeacaoWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      {:ok, token, _} = sign_in(user)

      conn
      |> put_status(:created)
      |> render("created.json", user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user! id
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"user" => user_params}) do
    user = current_user(conn)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end
end