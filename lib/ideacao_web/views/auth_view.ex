defmodule IdeacaoWeb.AuthView do
  use IdeacaoWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
