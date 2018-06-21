defmodule IdeacaoWeb.IdeaControllerTest do
  use IdeacaoWeb.ConnCase

  alias Ideacao.Accounts
  alias Ideacao.Ideas
  alias Ideacao.Ideas.Idea

  @create_attrs %{description: "some description", title: "some title", problem: "some problem", target: "some target"}
  @update_attrs %{description: "some updated description", title: "some updated title", problem: "some updated problem", target: "some updated target"}
  @invalid_attrs %{description: nil, title: nil, problem: nil, target: nil}

  def fixture(:user) do
    timestamp = :os.system_time(:micro_seconds)
    {:ok, user} = Accounts.create_user %{name: "User Test", email: "user#{timestamp}@example.com",
                                         password: "123456", password_confirmation: "123456"}

    user
  end

  def fixture(:idea, user) do
    create_attrs = Map.put(@create_attrs, :author_id, user.id)
    {:ok, idea} = Ideas.create_idea(create_attrs)
    idea
  end

  setup %{conn: conn} do
    user = fixture(:user)
    {:ok, token, _} = IdeacaoWeb.Auth.Guardian.encode_and_sign(user)

    conn = conn
      |> put_req_header("accept", "application/json")
      |> put_auth_token(token)

    {:ok, conn: conn, user: user, token: token}
  end

  describe "index" do
    test "lists all ideas", %{conn: conn} do
      conn = get conn, idea_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create idea" do
    test "renders idea when data is valid", %{conn: conn, token: token, user: user} do
      conn = post conn, idea_path(conn, :create), idea: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get authenticated_conn(token), idea_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "title" => "some title",
        "problem" => "some problem",
        "target" => "some target",
        "author" => %{
          "id" => user.id,
          "name" => user.name
        }}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, idea_path(conn, :create), idea: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update idea" do
    setup [:create_idea]

    test "renders idea when data is valid", %{conn: conn, idea: %Idea{id: id} = idea, token: token, user: user} do
      conn = put conn, idea_path(conn, :update, idea), idea: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get authenticated_conn(token), idea_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "title" => "some updated title",
        "problem" => "some updated problem",
        "target" => "some updated target",
        "author" => %{
          "id" => user.id,
          "name" => user.name
        }
      }
    end

    test "renders errors when data is invalid", %{conn: conn, idea: idea} do
      conn = put conn, idea_path(conn, :update, idea), idea: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete idea" do
    setup [:create_idea]

    test "deletes chosen idea", %{conn: conn, idea: idea, token: token} do
      conn = delete conn, idea_path(conn, :delete, idea)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get authenticated_conn(token), idea_path(conn, :show, idea)
      end
    end
  end

  defp create_idea(_) do
    user = fixture(:user)
    idea = fixture(:idea, user)
    {:ok, idea: idea}
  end
end
