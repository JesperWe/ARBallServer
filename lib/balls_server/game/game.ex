defmodule BallsServer.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias BallsServer.Repo

  alias BallsServer.Game.Ball

  @doc """
  Returns the list of balls.

  ## Examples

      iex> list_balls()
      [%Ball{}, ...]

  """
  def list_balls do
    Repo.all(Ball)
  end

  @doc """
  Gets a single ball.

  Raises `Ecto.NoResultsError` if the Ball does not exist.

  ## Examples

      iex> get_ball!(123)
      %Ball{}

      iex> get_ball!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ball!(id), do: Repo.get!(Ball, id)

  @doc """
  Creates a ball.

  ## Examples

      iex> create_ball(%{field: value})
      {:ok, %Ball{}}

      iex> create_ball(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ball(attrs \\ %{}) do
    %Ball{}
    |> Ball.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ball.

  ## Examples

      iex> update_ball(ball, %{field: new_value})
      {:ok, %Ball{}}

      iex> update_ball(ball, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ball(%Ball{} = ball, attrs) do
    ball
    |> Ball.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ball.

  ## Examples

      iex> delete_ball(ball)
      {:ok, %Ball{}}

      iex> delete_ball(ball)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ball(%Ball{} = ball) do
    Repo.delete(ball)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ball changes.

  ## Examples

      iex> change_ball(ball)
      %Ecto.Changeset{source: %Ball{}}

  """
  def change_ball(%Ball{} = ball) do
    Ball.changeset(ball, %{})
  end
end
