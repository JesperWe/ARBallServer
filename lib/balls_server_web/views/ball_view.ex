defmodule BallsServerWeb.BallView do
  use BallsServerWeb, :view
  alias BallsServerWeb.BallView

  def render("index.json", %{balls: balls}) do
    %{data: render_many(balls, BallView, "ball.json")}
  end

  def render("show.json", %{ball: ball}) do
    %{data: render_one(ball, BallView, "ball.json")}
  end

  def render("ball.json", %{ball: ball}) do
    %{id: ball.id,
      shape: ball.shape,
      x: ball.x,
      y: ball.y,
      z: ball.z}
  end
end
