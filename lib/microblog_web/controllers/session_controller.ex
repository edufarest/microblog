defmodule MicroblogWeb.SessionController do
    use MicroblogWeb, :controller

    alias Microblog.Account

    def login(conn, %{"email" => email}) do
        user = Account.get_user_by_email!(email)

        if user do
            conn
            |> put_session(:user_id, user.id)
            |> put_flash(:info, "Logged in as #{user.email}")
            |> redirect(to: message_path(conn, :index))
        else
            conn
            |> put_session(:user_id, nil)
            |> put_flash(:error, "No such user")
            |> redirect(to: message_path(conn, :index))
        end
    end

    def logout(conn, _params) do
        conn
        |> put_session(:user_id, nil)
        |> put_flash(:info, "Logged out")
        |> redirect(to: message_path(conn, :index))
    end
end
