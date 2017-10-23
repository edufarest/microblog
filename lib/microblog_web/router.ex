defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  import MicroblogWeb.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MicroblogWeb do
    pipe_through :browser # Use the default browser stack
	
    
    get "/", PageController, :index
    get "/welcome", WelcomeController, :index

    resources "/messages", MessageController
    resources "/users", UserController
    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
    resources "/following", FollowsController
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", MicroblogWeb do
    pipe_through :api

    resources "/likes", LikeController, except: [:new, :edit]

  end
end
