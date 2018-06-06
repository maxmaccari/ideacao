defmodule IdeacaoWeb.FeedbackController do
  use IdeacaoWeb, :controller

  alias Ideacao.Ideas
  alias Ideacao.Ideas.Feedback

  action_fallback IdeacaoWeb.FallbackController

  def index(conn, _params) do
    feedbacks = Ideas.list_feedbacks()
    render(conn, "index.json", feedbacks: feedbacks)
  end

  def create(conn, %{"feedback" => feedback_params}) do
    with {:ok, %Feedback{} = feedback} <- Ideas.create_feedback(feedback_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", feedback_path(conn, :show, feedback))
      |> render("show.json", feedback: feedback)
    end
  end

  def show(conn, %{"id" => id}) do
    feedback = Ideas.get_feedback!(id)
    render(conn, "show.json", feedback: feedback)
  end

  def update(conn, %{"id" => id, "feedback" => feedback_params}) do
    feedback = Ideas.get_feedback!(id)

    with {:ok, %Feedback{} = feedback} <- Ideas.update_feedback(feedback, feedback_params) do
      render(conn, "show.json", feedback: feedback)
    end
  end

  def delete(conn, %{"id" => id}) do
    feedback = Ideas.get_feedback!(id)
    with {:ok, %Feedback{}} <- Ideas.delete_feedback(feedback) do
      send_resp(conn, :no_content, "")
    end
  end
end
