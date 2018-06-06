defmodule Ideacao.AccountsTest do
  use Ideacao.DataCase

  alias Ideacao.Accounts

  describe "users" do
    alias Ideacao.Accounts.User

    @valid_attrs %{email: "some email", password: "123456", password_confirmation: "123456", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name", password: "654321",
                    password_confirmation: "654321"}
    @invalid_attrs %{email: nil, password: "123", password_confirmation: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user! user.id
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user without update the password" do
      old_user = user_fixture()
      assert {:ok, user} = Accounts.update_user(old_user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.encrypted_password == old_user.encrypted_password
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "update_user_registration/2 with valid data updates the user including password" do
      old_user = user_fixture()
      assert {:ok, user} = Accounts.update_user_registration(old_user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      refute user.encrypted_password == old_user.encrypted_password
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "change_user_registration/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_registration(user)
    end

    test "authenticate_user/2 with correct credentials returns the user" do
      user = user_fixture()
      assert Accounts.authenticate_user("some email", "123456") == {:ok, user}
    end

    test "authenticate_user/2 with incorrect credentials returns an error" do
      user_fixture()
      assert Accounts.authenticate_user("wrong", "wrong") == {:error, "Incorrect username or password"}
    end
  end
end
