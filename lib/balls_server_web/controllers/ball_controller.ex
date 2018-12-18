defmodule BallsServerWeb.BallController do
  use BallsServerWeb, :controller

  alias BallsServer.Game
  alias BallsServer.Game.Ball

  action_fallback BallsServerWeb.FallbackController

  def index(conn, _params) do
    balls = Game.list_balls()
    render(conn, "index.json", balls: balls)
  end

  def new(conn, _params) do
    balls = Game.list_balls()
    render(conn, "index.json", balls: balls)
  end

  def create(conn, %{"ball" => ball_params}) do
    with {:ok, %Ball{} = ball} <- Game.create_ball(ball_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.ball_path(conn, :show, ball))
      |> render("show.json", ball: ball)
    end
  end

  def show(conn, %{"id" => id}) do
    ball = Game.get_ball!(id)
    render(conn, "show.json", ball: ball)
  end

  def update(conn, %{"id" => id, "ball" => ball_params}) do
    ball = Game.get_ball!(id)

    with {:ok, %Ball{} = ball} <- Game.update_ball(ball, ball_params) do
      render(conn, "show.json", ball: ball)
    end
  end

  def delete(conn, %{"id" => id}) do
    ball = Game.get_ball!(id)

    with {:ok, %Ball{}} <- Game.delete_ball(ball) do
      send_resp(conn, :no_content, "")
    end
  end
end
