defmodule Microblog.Repo.Migrations.AddPoster do
  use Ecto.Migration

  def change do
    alter table(:messages) do
        add :poster, :text

      end
  end
end
