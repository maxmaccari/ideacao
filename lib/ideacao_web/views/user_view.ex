defmodule IdeacaoWeb.UserView do
  use IdeacaoWeb, :view
  alias IdeacaoWeb.UserView

  def render("index.json", %{users: users}) do
    %{users: render_many(users, UserView, "user.json")}
  end

  def render("created.json", %{user: user, token: token}) do
    %{user: render_one(user, UserView, "user.json"),
      token: token}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name}
  end
end
