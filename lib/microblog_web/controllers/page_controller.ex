defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller
  import Plug.Conn

  def index(conn, _params) do
    if get_session(conn, :user_id) do
      redirect conn, to: message_path(conn, :index)
    else
      redirect conn, to: welcome_path(conn, :index)
    end
  end
end
