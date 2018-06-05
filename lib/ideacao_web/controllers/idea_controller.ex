defmodule IdeacaoWeb.IdeaController do
  use IdeacaoWeb, :controller

  alias Ideacao.Ideas
  alias Ideacao.Ideas.Idea

  action_fallback IdeacaoWeb.FallbackController

  def index(conn, _params) do
    ideas = Ideas.list_ideas()
    render(conn, "index.json", ideas: ideas)
  end

  def create(conn, %{"idea" => idea_params}) do
    with {:ok, %Idea{} = idea} <- Ideas.create_idea(idea_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", idea_path(conn, :show, idea))
      |> render("show.json", idea: idea)
    end
  end

  def show(conn, %{"id" => id}) do
    idea = Ideas.get_idea!(id)
    render(conn, "show.json", idea: idea)
  end

  def update(conn, %{"id" => id, "idea" => idea_params}) do
    idea = Ideas.get_idea!(id)

    with {:ok, %Idea{} = idea} <- Ideas.update_idea(idea, idea_params) do
      render(conn, "show.json", idea: idea)
    end
  end

  def delete(conn, %{"id" => id}) do
    idea = Ideas.get_idea!(id)
    with {:ok, %Idea{}} <- Ideas.delete_idea(idea) do
      send_resp(conn, :no_content, "")
    end
  end
end
