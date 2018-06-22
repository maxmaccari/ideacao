defmodule IdeacaoWeb.AuthView do
  use IdeacaoWeb, :view

  def render("auth.json", %{token: token, user: user}) do
    %{token: token,
      user: %{
        id: user.id,
        name: user.name
      }}
  end
end
