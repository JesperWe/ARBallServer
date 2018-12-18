defmodule BallsServer.Repo.Migrations.CreateBalls do
  use Ecto.Migration

  def change do
    create table(:balls) do
      add :shape, :string
      add :x, :float
      add :y, :float
      add :z, :float

      timestamps()
    end

  end
end
