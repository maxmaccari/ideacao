defmodule IdeacaoWeb.FeedbackView do
  use IdeacaoWeb, :view
  alias IdeacaoWeb.FeedbackView

  def render("index.json", %{feedbacks: feedbacks}) do
    %{data: render_many(feedbacks, FeedbackView, "feedback.json")}
  end

  def render("show.json", %{feedback: feedback}) do
    %{data: render_one(feedback, FeedbackView, "feedback.json")}
  end

  def render("feedback.json", %{feedback: feedback}) do
    %{id: feedback.id,
      rate: feedback.rate,
      comment: feedback.comment,
      user: %{
        id: feedback.user.id,
        name: feedback.user.name
      }}
  end
end
