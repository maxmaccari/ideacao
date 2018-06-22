defmodule IdeacaoWeb.IdeasChannel do
  use IdeacaoWeb, :channel

  def join("ideas:lobby", _payload, socket) do
    {:ok, socket}
  end
end
