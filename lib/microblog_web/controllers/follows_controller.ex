defmodule MicroblogWeb.FollowsController do
  use MicroblogWeb, :controller

  alias Microblog.Account
  alias Microblog.Account.Follows

  def index(conn, _params) do
    following = Account.list_following()
    render(conn, "index.html", following: following)
  end

  def new(conn, _params) do
    changeset = Account.change_follows(%Follows{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"follows" => follows_params}) do
    case Account.create_follows(follows_params) do
      {:ok, follows} ->
        conn
        |> put_flash(:info, "Follows created successfully.")
        |> redirect(to: follows_path(conn, :show, follows))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    follows = Account.get_follows!(id)
    render(conn, "show.html", follows: follows)
  end

  def edit(conn, %{"id" => id}) do
    follows = Account.get_follows!(id)
    changeset = Account.change_follows(follows)
    render(conn, "edit.html", follows: follows, changeset: changeset)
  end

  def update(conn, %{"id" => id, "follows" => follows_params}) do
    follows = Account.get_follows!(id)

    case Account.update_follows(follows, follows_params) do
      {:ok, follows} ->
        conn
        |> put_flash(:info, "Follows updated successfully.")
        |> redirect(to: follows_path(conn, :show, follows))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", follows: follows, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    follows = Account.get_follows!(id)
    {:ok, _follows} = Account.delete_follows(follows)

    conn
    |> put_flash(:info, "Follows deleted successfully.")
    |> redirect(to: follows_path(conn, :index))
  end
end
