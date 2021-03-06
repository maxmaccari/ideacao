defmodule IdeacaoWeb.IdeaView do
  use IdeacaoWeb, :view
  alias IdeacaoWeb.IdeaView

  def render("index.json", %{ideas: ideas}) do
    %{ideas: render_many(ideas, IdeaView, "idea.json")}
  end

  def render("show.json", %{idea: idea}) do
    %{idea: render_one(idea, IdeaView, "idea.json")}
  end

  def render("idea.json", %{idea: idea}) do
    %{id: idea.id,
      title: idea.title,
      target: idea.target,
      problem: idea.problem,
      description: idea.description,
      author: %{
        id: idea.author.id,
        name: idea.author.name
      }}
  end
end
