defmodule IdeacaoWeb.AuthControllerTest do
  use IdeacaoWeb.ConnCase

  alias Ideacao.Accounts

  @valid_credentials %{user: %{email: "user@example.com", password: "123456"}}
  @invalid_credentials %{user: %{email: "wrong@example.com", password: "wrong"}}

  def fixture(:user) do
    user_params = Map.put(@valid_credentials.user, :name, "User Test")
      |> Map.put(:password_confirmation, @valid_credentials.user.password)
    {:ok, user} = Accounts.create_user user_params

    user
  end

  setup %{conn: conn} do
    user = fixture(:user)

    {:ok, conn: conn, user: user}
  end

  describe "authentication" do
    test "authenticate user with valid credentials returns the token", %{conn: conn, user: user} do
      conn = post conn, auth_path(conn, :sign_in), @valid_credentials
      assert json_response(conn, 200)["token"] != ""
      assert json_response(conn, 200)["user"] == %{
        "id" => user.id,
        "name" => user.name
      }
    end

    test "authenticate user with invalid credentials returns an error", %{conn: conn} do
      conn = post conn, auth_path(conn, :sign_in), @invalid_credentials
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
