defmodule MicroblogWeb.MessageController do
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Blog.Message

  def index(conn, _params) do
    messages = Enum.reverse(Blog.list_messages())
    follows = Microblog.Account.list_following()
    render(conn, "index.html", messages: messages, follows: follows)
  end

  def new(conn, _params) do
    changeset = Blog.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Blog.create_message(message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        #|> redirect(to: message_path(conn, :index, message))
        index(conn, nil)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "show.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Blog.get_message!(id)
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Blog.get_message!(id)
    changeset = Blog.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Blog.get_message!(id)

    case Blog.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: message_path(conn, :show, message))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Blog.get_message!(id)
    {:ok, _message} = Blog.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
