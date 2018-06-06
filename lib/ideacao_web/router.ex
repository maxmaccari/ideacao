defmodule IdeacaoWeb.Router do
  use IdeacaoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IdeacaoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", IdeacaoWeb do
    pipe_through :api

    resources "/ideas", IdeaController, except: [:new, :edit] do
      resources "/feedbacks", FeedbackController, except: [:new, :edit, :show]
    end
    resources "/feedbacks", FeedbackController, except: [:new, :edit]
  end
end
