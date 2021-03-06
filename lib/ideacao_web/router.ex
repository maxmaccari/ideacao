defmodule IdeacaoWeb.Router do
  use IdeacaoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug IdeacaoWeb.Auth.Pipeline
  end

  scope "/api", IdeacaoWeb do
    pipe_through :api

    post "/users/sign_in", AuthController, :sign_in
    resources "/users", UserController, only: [:create]
  end

  scope "/api", IdeacaoWeb do
    pipe_through [:api, :auth]

    resources "/ideas", IdeaController, except: [:new, :edit] do
      resources "/feedbacks", FeedbackController, except: [:new, :edit]
    end

    put "/user", UserController, :update
    resources "/users", UserController, only: [:index, :show]
  end

  scope "/", IdeacaoWeb do
    pipe_through :browser # Use the default browser stack

    forward "/", StaticPlug
  end
end
