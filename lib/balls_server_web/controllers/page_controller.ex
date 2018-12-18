defmodule BallsServerWeb.PageController do
  use BallsServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
