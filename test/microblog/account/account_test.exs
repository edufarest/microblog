defmodule Microblog.AccountTest do
  use Microblog.DataCase

  alias Microblog.Account

  describe "users" do
    alias Microblog.Account.User

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.email == "some email"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Account.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "following" do
    alias Microblog.Account.Follows

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follows_fixture(attrs \\ %{}) do
      {:ok, follows} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_follows()

      follows
    end

    test "list_following/0 returns all following" do
      follows = follows_fixture()
      assert Account.list_following() == [follows]
    end

    test "get_follows!/1 returns the follows with given id" do
      follows = follows_fixture()
      assert Account.get_follows!(follows.id) == follows
    end

    test "create_follows/1 with valid data creates a follows" do
      assert {:ok, %Follows{} = follows} = Account.create_follows(@valid_attrs)
    end

    test "create_follows/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_follows(@invalid_attrs)
    end

    test "update_follows/2 with valid data updates the follows" do
      follows = follows_fixture()
      assert {:ok, follows} = Account.update_follows(follows, @update_attrs)
      assert %Follows{} = follows
    end

    test "update_follows/2 with invalid data returns error changeset" do
      follows = follows_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_follows(follows, @invalid_attrs)
      assert follows == Account.get_follows!(follows.id)
    end

    test "delete_follows/1 deletes the follows" do
      follows = follows_fixture()
      assert {:ok, %Follows{}} = Account.delete_follows(follows)
      assert_raise Ecto.NoResultsError, fn -> Account.get_follows!(follows.id) end
    end

    test "change_follows/1 returns a follows changeset" do
      follows = follows_fixture()
      assert %Ecto.Changeset{} = Account.change_follows(follows)
    end
  end

  describe "following" do
    alias Microblog.Account.Follows

    @valid_attrs %{followed_user: "some followed_user", user: "some user"}
    @update_attrs %{followed_user: "some updated followed_user", user: "some updated user"}
    @invalid_attrs %{followed_user: nil, user: nil}

    def follows_fixture(attrs \\ %{}) do
      {:ok, follows} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_follows()

      follows
    end

    test "list_following/0 returns all following" do
      follows = follows_fixture()
      assert Account.list_following() == [follows]
    end

    test "get_follows!/1 returns the follows with given id" do
      follows = follows_fixture()
      assert Account.get_follows!(follows.id) == follows
    end

    test "create_follows/1 with valid data creates a follows" do
      assert {:ok, %Follows{} = follows} = Account.create_follows(@valid_attrs)
      assert follows.followed_user == "some followed_user"
      assert follows.user == "some user"
    end

    test "create_follows/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_follows(@invalid_attrs)
    end

    test "update_follows/2 with valid data updates the follows" do
      follows = follows_fixture()
      assert {:ok, follows} = Account.update_follows(follows, @update_attrs)
      assert %Follows{} = follows
      assert follows.followed_user == "some updated followed_user"
      assert follows.user == "some updated user"
    end

    test "update_follows/2 with invalid data returns error changeset" do
      follows = follows_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_follows(follows, @invalid_attrs)
      assert follows == Account.get_follows!(follows.id)
    end

    test "delete_follows/1 deletes the follows" do
      follows = follows_fixture()
      assert {:ok, %Follows{}} = Account.delete_follows(follows)
      assert_raise Ecto.NoResultsError, fn -> Account.get_follows!(follows.id) end
    end

    test "change_follows/1 returns a follows changeset" do
      follows = follows_fixture()
      assert %Ecto.Changeset{} = Account.change_follows(follows)
    end
  end
end
