defmodule IdeacaoWeb.FeedbackView do
  use IdeacaoWeb, :view
  alias IdeacaoWeb.FeedbackView

  def render("index.json", %{feedbacks: feedbacks}) do
    %{feedbacks: render_many(feedbacks, FeedbackView, "feedback.json")}
  end

  def render("show.json", %{feedback: feedback}) do
    %{feedback: render_one(feedback, FeedbackView, "feedback.json")}
  end

  def render("feedback.json", %{feedback: feedback}) do
    %{id: feedback.id,
      rating: feedback.rating,
      comment: feedback.comment,
      user: %{
        id: feedback.user.id,
        name: feedback.user.name
      }}
  end
end
