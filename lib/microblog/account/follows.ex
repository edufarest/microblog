defmodule Microblog.Account.Follows do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Account.Follows


  schema "following" do
    field :followed_user, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(%Follows{} = follows, attrs) do
    follows
    |> cast(attrs, [:user, :followed_user])
    |> validate_required([:user, :followed_user])
  end
end
