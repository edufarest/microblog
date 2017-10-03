defmodule Microblog.Blog.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Message


  schema "messages" do
    field :content, :string
    field :poster,  :string

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:content, :poster])
    |> validate_required([:content, :poster])
  end
end
