defmodule IdeacaoWeb.Auth do
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def sign_in(user) do
    IdeacaoWeb.Auth.Guardian.encode_and_sign(user)
  end
end