defmodule IdeacaoWeb.Auth do
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def sign_in(user) do
    IdeacaoWeb.Auth.Guardian.encode_and_sign(user)
  end

  def user_from_token(token) do
    case IdeacaoWeb.Auth.Guardian.decode_and_verify(token, %{"typ" => "access"}) do
      {:ok, realm} -> {:ok, Ideacao.Accounts.get_user!(realm["sub"])}
      _ -> {:error, :not_signed_in}
    end
  end
end