defmodule MicroblogWeb.FollowsControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Account

  @create_attrs %{followed_user: "some followed_user", user: "some user"}
  @update_attrs %{followed_user: "some updated followed_user", user: "some updated user"}
  @invalid_attrs %{followed_user: nil, user: nil}

  def fixture(:follows) do
    {:ok, follows} = Account.create_follows(@create_attrs)
    follows
  end

  describe "index" do
    test "lists all following", %{conn: conn} do
      conn = get conn, follows_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Following"
    end
  end

  describe "new follows" do
    test "renders form", %{conn: conn} do
      conn = get conn, follows_path(conn, :new)
      assert html_response(conn, 200) =~ "New Follows"
    end
  end

  describe "create follows" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, follows_path(conn, :create), follows: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == follows_path(conn, :show, id)

      conn = get conn, follows_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Follows"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, follows_path(conn, :create), follows: @invalid_attrs
      assert html_response(conn, 200) =~ "New Follows"
    end
  end

  describe "edit follows" do
    setup [:create_follows]

    test "renders form for editing chosen follows", %{conn: conn, follows: follows} do
      conn = get conn, follows_path(conn, :edit, follows)
      assert html_response(conn, 200) =~ "Edit Follows"
    end
  end

  describe "update follows" do
    setup [:create_follows]

    test "redirects when data is valid", %{conn: conn, follows: follows} do
      conn = put conn, follows_path(conn, :update, follows), follows: @update_attrs
      assert redirected_to(conn) == follows_path(conn, :show, follows)

      conn = get conn, follows_path(conn, :show, follows)
      assert html_response(conn, 200) =~ "some updated followed_user"
    end

    test "renders errors when data is invalid", %{conn: conn, follows: follows} do
      conn = put conn, follows_path(conn, :update, follows), follows: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Follows"
    end
  end

  describe "delete follows" do
    setup [:create_follows]

    test "deletes chosen follows", %{conn: conn, follows: follows} do
      conn = delete conn, follows_path(conn, :delete, follows)
      assert redirected_to(conn) == follows_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, follows_path(conn, :show, follows)
      end
    end
  end

  defp create_follows(_) do
    follows = fixture(:follows)
    {:ok, follows: follows}
  end
end
