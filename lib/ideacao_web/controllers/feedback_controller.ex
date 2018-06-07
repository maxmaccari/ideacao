defmodule IdeacaoWeb.FeedbackController do
  use IdeacaoWeb, :controller

  alias Ideacao.Ideas
  alias Ideacao.Ideas.Feedback

  action_fallback IdeacaoWeb.FallbackController

  plug :load_feedback when action in [:update, :delete]

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

  def update(conn, %{"feedback" => feedback_params}) do
    feedback = conn.assigns[:feedback] |> Ideas.preload_user

    with {:ok, %Feedback{} = feedback} <- Ideas.update_feedback(feedback, feedback_params) do
      render(conn, "show.json", feedback: feedback)
    end
  end

  def delete(conn, _params) do
    feedback = conn.assigns[:feedback]

    with {:ok, %Feedback{}} <- Ideas.delete_feedback(feedback) do
      send_resp(conn, :no_content, "")
    end
  end

  defp load_feedback(conn, _) do
    %{"idea_id" => idea_id, "id" => id} = conn.params
    idea = Ideas.get_idea!(idea_id)
    user = current_user(conn)

    case Ideas.get_feedback(idea, user, id) do
      {:ok, feedback} -> assign(conn, :feedback, feedback)
      {:error, :not_found} ->
        conn
        |> put_status(:unauthorized)
        |> render(IdeacaoWeb.ErrorView, "error.json", message: "The user is not authorized to perform this action.")
        |> halt()
    end
  end
end
