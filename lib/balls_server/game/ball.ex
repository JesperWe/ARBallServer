defmodule BallsServer.Game.Ball do
  use Ecto.Schema
  import Ecto.Changeset


  schema "balls" do
    field :shape, :string
    field :x, :float
    field :y, :float
    field :z, :float

    timestamps()
  end

  @doc false
  def changeset(ball, attrs) do
    ball
    |> cast(attrs, [:shape, :x, :y, :z])
    |> validate_required([:shape, :x, :y, :z])
  end
end
