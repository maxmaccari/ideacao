defmodule IdeacaoWeb.UserControllerTest do
  use IdeacaoWeb.ConnCase

  alias Ideacao.Accounts
  alias Ideacao.Accounts.User

  @create_attrs %{email: "user@example.com", password: "s3cr3t", password_confirmation: "s3cr3t", name: "Some Name"}
  @update_attrs %{email: "updated_user@example.com", name: "Some Updated Name"}
  @invalid_attrs %{email: "user_example com", password: "wrong", password_confirmation: "wrong", name: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user @create_attrs

    user
  end

  describe "index" do
    setup [:create_user]

    test "lists all users", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200)["users"] == [
        %{
          "id" => user.id,
          "email" => user.email,
          "name" => user.name}
      ]
    end
  end

  describe "create user" do
    test "renders user and token when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["user"]
      assert json_response(conn, 201)["user"] == %{
        "id" => id,
        "email" => "user@example.com",
        "name" => "Some Name"}
      assert json_response(conn, 201)["token"] != ""
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id}, token: token} do
      conn = put conn, user_path(conn, :update), user: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["user"]

      conn = get authenticated_conn(token), user_path(conn, :show, id)
      assert json_response(conn, 200)["user"] == %{
        "id" => id,
        "email" => "updated_user@example.com",
        "name" => "Some Updated Name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = put conn, user_path(conn, :update), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_user(%{conn: conn}) do
    user = fixture(:user)
    {:ok, token, _} = IdeacaoWeb.Auth.Guardian.encode_and_sign(user)

    {:ok, conn: put_auth_token(conn, token), user: user, token: token}
  end

end
