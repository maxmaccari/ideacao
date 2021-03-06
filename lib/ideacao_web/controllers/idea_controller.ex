defmodule IdeacaoWeb.IdeaController do
  use IdeacaoWeb, :controller

  alias Ideacao.Ideas
  alias Ideacao.Ideas.Idea

  action_fallback IdeacaoWeb.FallbackController

  def index(conn, _params) do
    ideas = Ideas.list_ideas() |> Ideas.preload_author()
    render(conn, "index.json", ideas: ideas)
  end

  def create(conn, %{"idea" => idea_params}) do
    author = current_user(conn)
    idea_params = Map.put(idea_params, "author_id", author.id)

    with {:ok, %Idea{} = idea} <- Ideas.create_idea(idea_params) do
      idea = %{idea | author: author}
      broadcast_new_idea(idea)

      conn
      |> put_status(:created)
      |> put_resp_header("location", idea_path(conn, :show, idea))
      |> render("show.json", idea: idea)
    end
  end

  def show(conn, %{"id" => id}) do
    idea = Ideas.get_idea!(id) |> Ideas.preload_author()
    render(conn, "show.json", idea: idea)
  end

  def update(conn, %{"id" => id, "idea" => idea_params}) do
    author = current_user(conn)
    idea_params = Map.put(idea_params, "author_id", author.id)

    idea = Ideas.get_idea!(id)

    with {:ok, %Idea{} = idea} <- Ideas.update_idea(idea, idea_params) do
      render(conn, "show.json", idea: Ideas.preload_author(idea))
    end
  end

  def delete(conn, %{"id" => id}) do
    idea = Ideas.get_idea!(id)

    with {:ok, %Idea{}} <- Ideas.delete_idea(idea) do
      send_resp(conn, :no_content, "")
    end
  end

  defp broadcast_new_idea(idea) do
    IdeacaoWeb.Endpoint.broadcast("ideas:lobby", "newIdea", %{
      id: idea.id,
      title: idea.title,
      target: idea.target,
      problem: idea.problem,
      description: idea.description,
      feedbacks: [],
      author: %{
        id: idea.author.id,
        name: idea.author.name
      }
    })
  end
end
