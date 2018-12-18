defmodule BallsServerWeb.Router do
  use BallsServerWeb, :router

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

  scope "/", BallsServerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", BallsServerWeb do
    pipe_through :api
    resources "/balls", BallController
  end
end
