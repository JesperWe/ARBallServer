defmodule BallsServer.GameTest do
  use BallsServer.DataCase

  alias BallsServer.Game

  describe "balls" do
    alias BallsServer.Game.Ball

    @valid_attrs %{shape: "some shape", x: 120.5, y: 120.5, z: 120.5}
    @update_attrs %{shape: "some updated shape", x: 456.7, y: 456.7, z: 456.7}
    @invalid_attrs %{shape: nil, x: nil, y: nil, z: nil}

    def ball_fixture(attrs \\ %{}) do
      {:ok, ball} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Game.create_ball()

      ball
    end

    test "list_balls/0 returns all balls" do
      ball = ball_fixture()
      assert Game.list_balls() == [ball]
    end

    test "get_ball!/1 returns the ball with given id" do
      ball = ball_fixture()
      assert Game.get_ball!(ball.id) == ball
    end

    test "create_ball/1 with valid data creates a ball" do
      assert {:ok, %Ball{} = ball} = Game.create_ball(@valid_attrs)
      assert ball.shape == "some shape"
      assert ball.x == 120.5
      assert ball.y == 120.5
      assert ball.z == 120.5
    end

    test "create_ball/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_ball(@invalid_attrs)
    end

    test "update_ball/2 with valid data updates the ball" do
      ball = ball_fixture()
      assert {:ok, %Ball{} = ball} = Game.update_ball(ball, @update_attrs)
      assert ball.shape == "some updated shape"
      assert ball.x == 456.7
      assert ball.y == 456.7
      assert ball.z == 456.7
    end

    test "update_ball/2 with invalid data returns error changeset" do
      ball = ball_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_ball(ball, @invalid_attrs)
      assert ball == Game.get_ball!(ball.id)
    end

    test "delete_ball/1 deletes the ball" do
      ball = ball_fixture()
      assert {:ok, %Ball{}} = Game.delete_ball(ball)
      assert_raise Ecto.NoResultsError, fn -> Game.get_ball!(ball.id) end
    end

    test "change_ball/1 returns a ball changeset" do
      ball = ball_fixture()
      assert %Ecto.Changeset{} = Game.change_ball(ball)
    end
  end
end
