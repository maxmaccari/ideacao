defmodule IdeacaoWeb.FeedbackController do
  use IdeacaoWeb, :controller

  alias Ideacao.Ideas
  alias Ideacao.Ideas.Feedback

  action_fallback IdeacaoWeb.FallbackController

  def index(conn, %{"idea_id" => idea_id}) do
    idea = Ideas.get_idea!(idea_id)
    feedbacks = Ideas.list_feedbacks(idea) |> Ideas.preload_user
    render(conn, "index.json", feedbacks: feedbacks)
  end

  def create(conn, %{"idea_id" => idea_id, "feedback" => feedback_params}) do
    user = current_user(conn)
    feedback_params = Map.merge(feedback_params, %{"idea_id" => idea_id,
                                                   "user_id" => user.id})

    with {:ok, %Feedback{} = feedback} <- Ideas.create_feedback(feedback_params) do
      feedback = Ideas.preload_user(feedback)
      conn
      |> put_status(:created)
      |> put_resp_header("location", idea_feedback_path(conn, :show, idea_id, feedback))
      |> render("show.json", feedback: feedback)
    end
  end

  def show(conn, %{"idea_id" => idea_id, "id" => id}) do
    idea = Ideas.get_idea!(idea_id)
    feedback = Ideas.get_feedback!(idea, id) |> Ideas.preload_user
    render(conn, "show.json", feedback: feedback)
  end

  def update(conn, %{"idea_id" => idea_id, "id" => id, "feedback" => feedback_params}) do
    idea = Ideas.get_idea!(idea_id)
    feedback = Ideas.get_feedback!(idea, id) |> Ideas.preload_user

    with {:ok, %Feedback{} = feedback} <- Ideas.update_feedback(feedback, feedback_params) do
      render(conn, "show.json", feedback: feedback)
    end
  end

  def delete(conn, %{"idea_id" => idea_id, "id" => id}) do
    idea = Ideas.get_idea!(idea_id)
    feedback = Ideas.get_feedback!(idea, id)
    with {:ok, %Feedback{}} <- Ideas.delete_feedback(feedback) do
      send_resp(conn, :no_content, "")
    end
  end
end
