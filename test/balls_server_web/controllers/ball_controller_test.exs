defmodule BallsServerWeb.BallControllerTest do
  use BallsServerWeb.ConnCase

  alias BallsServer.Game
  alias BallsServer.Game.Ball

  @create_attrs %{
    shape: "some shape",
    x: 120.5,
    y: 120.5,
    z: 120.5
  }
  @update_attrs %{
    shape: "some updated shape",
    x: 456.7,
    y: 456.7,
    z: 456.7
  }
  @invalid_attrs %{shape: nil, x: nil, y: nil, z: nil}

  def fixture(:ball) do
    {:ok, ball} = Game.create_ball(@create_attrs)
    ball
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all balls", %{conn: conn} do
      conn = get(conn, Routes.ball_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create ball" do
    test "renders ball when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ball_path(conn, :create), ball: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.ball_path(conn, :show, id))

      assert %{
               "id" => id,
               "shape" => "some shape",
               "x" => 120.5,
               "y" => 120.5,
               "z" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ball_path(conn, :create), ball: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update ball" do
    setup [:create_ball]

    test "renders ball when data is valid", %{conn: conn, ball: %Ball{id: id} = ball} do
      conn = put(conn, Routes.ball_path(conn, :update, ball), ball: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.ball_path(conn, :show, id))

      assert %{
               "id" => id,
               "shape" => "some updated shape",
               "x" => 456.7,
               "y" => 456.7,
               "z" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ball: ball} do
      conn = put(conn, Routes.ball_path(conn, :update, ball), ball: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ball" do
    setup [:create_ball]

    test "deletes chosen ball", %{conn: conn, ball: ball} do
      conn = delete(conn, Routes.ball_path(conn, :delete, ball))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.ball_path(conn, :show, ball))
      end
    end
  end

  defp create_ball(_) do
    ball = fixture(:ball)
    {:ok, ball: ball}
  end
end
