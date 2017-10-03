defmodule Microblog.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:following) do
      add :user, :text
      add :followed_user, :text

      timestamps()
    end

  end
end
