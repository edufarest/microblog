defmodule Microblog.Blog.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Like


  schema "likes" do
    belongs_to :message, Microblog.Blog.Message
    belongs_to :user, Microblog.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:message_id, :user_id])
    |> validate_required([:message_id, :user_id])
  end
end
