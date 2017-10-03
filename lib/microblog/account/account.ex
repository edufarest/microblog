defmodule Microblog.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
  
  def get_user_by_email!(email) do
    Repo.get_by(User, email: email)
  end

  alias Microblog.Account.Follows

  @doc """
  Returns the list of following.

  ## Examples

      iex> list_following()
      [%Follows{}, ...]

  """
  def list_following do
    Repo.all(Follows)
  end

  @doc """
  Gets a single follows.

  Raises `Ecto.NoResultsError` if the Follows does not exist.

  ## Examples

      iex> get_follows!(123)
      %Follows{}

      iex> get_follows!(456)
      ** (Ecto.NoResultsError)

  """
  def get_follows!(id), do: Repo.get!(Follows, id)

  @doc """
  Creates a follows.

  ## Examples

      iex> create_follows(%{field: value})
      {:ok, %Follows{}}

      iex> create_follows(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_follows(attrs \\ %{}) do
    %Follows{}
    |> Follows.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a follows.

  ## Examples

      iex> update_follows(follows, %{field: new_value})
      {:ok, %Follows{}}

      iex> update_follows(follows, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follows(%Follows{} = follows, attrs) do
    follows
    |> Follows.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follows.

  ## Examples

      iex> delete_follows(follows)
      {:ok, %Follows{}}

      iex> delete_follows(follows)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follows(%Follows{} = follows) do
    Repo.delete(follows)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follows changes.

  ## Examples

      iex> change_follows(follows)
      %Ecto.Changeset{source: %Follows{}}

  """
  def change_follows(%Follows{} = follows) do
    Follows.changeset(follows, %{})
  end
end
