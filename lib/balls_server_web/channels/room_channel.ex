defmodule BallsServerWeb.RoomChannel do
  use BallsServerWeb, :channel
  use BallsServerWeb, :view
  alias BallsServerWeb.BallView

  alias BallsServer.Game
  alias BallsServer.Game.Ball

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self, :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    ball = Game.get_ball!(2)
    push(socket, "msg", %{body: render_one(ball, BallView, "ball.json")})
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("update", %{"body" => ball_params}, socket) do
    ball = Game.get_ball!(2)

    with {:ok, %Ball{} = ball} <- Game.update_ball(ball, ball_params) do
      broadcast socket, "msg", %{body: render_one(ball, BallView, "ball.json")}
    end

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
