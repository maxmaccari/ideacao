defmodule IdeacaoWeb.AuthController do
  use IdeacaoWeb, :controller

  alias Ideacao.Accounts

  action_fallback IdeacaoWeb.FallbackController

  def sign_in(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
         {:ok, token, _claims} <- sign_in(user) do
      render conn, "auth.json", token: token, user: user
    end
  end
end