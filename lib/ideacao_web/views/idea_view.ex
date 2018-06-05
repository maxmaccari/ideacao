defmodule IdeacaoWeb.IdeaView do
  use IdeacaoWeb, :view
  alias IdeacaoWeb.IdeaView

  def render("index.json", %{ideas: ideas}) do
    %{data: render_many(ideas, IdeaView, "idea.json")}
  end

  def render("show.json", %{idea: idea}) do
    %{data: render_one(idea, IdeaView, "idea.json")}
  end

  def render("idea.json", %{idea: idea}) do
    %{id: idea.id,
      name: idea.name,
      target: idea.target,
      problem: idea.problem,
      description: idea.description}
  end
end
