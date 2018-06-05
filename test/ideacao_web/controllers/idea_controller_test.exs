defmodule IdeacaoWeb.IdeaControllerTest do
  use IdeacaoWeb.ConnCase

  alias Ideacao.Accounts
  alias Ideacao.Ideas
  alias Ideacao.Ideas.Idea

  @create_attrs %{description: "some description", name: "some name", problem: "some problem", target: "some target"}
  @update_attrs %{description: "some updated description", name: "some updated name", problem: "some updated problem", target: "some updated target"}
  @invalid_attrs %{description: nil, name: nil, problem: nil, target: nil}

  def fixture(:user) do
    timestamp = :os.system_time(:micro_seconds)
    {:ok, user} = Accounts.create_user %{name: "User Test", email: "user#{timestamp}@example.com"}
    user
  end

  def fixture(:idea, user) do
    create_attrs = Map.put(@create_attrs, :author_id, user.id)
    {:ok, idea} = Ideas.create_idea(create_attrs)
    idea
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: fixture(:user)}
  end

  describe "index" do
    test "lists all ideas", %{conn: conn} do
      conn = get conn, idea_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create idea" do
    test "renders idea when data is valid", %{conn: conn, user: user} do
      create_attrs = Map.put(@create_attrs, :author_id, user.id)
      conn = post conn, idea_path(conn, :create), idea: create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, idea_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name",
        "problem" => "some problem",
        "target" => "some target"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, idea_path(conn, :create), idea: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update idea" do
    setup [:create_idea]

    test "renders idea when data is valid", %{conn: conn, idea: %Idea{id: id} = idea} do
      conn = put conn, idea_path(conn, :update, idea), idea: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, idea_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name",
        "problem" => "some updated problem",
        "target" => "some updated target"}
    end

    test "renders errors when data is invalid", %{conn: conn, idea: idea} do
      conn = put conn, idea_path(conn, :update, idea), idea: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete idea" do
    setup [:create_idea]

    test "deletes chosen idea", %{conn: conn, idea: idea} do
      conn = delete conn, idea_path(conn, :delete, idea)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, idea_path(conn, :show, idea)
      end
    end
  end

  defp create_idea(_) do
    user = fixture(:user)
    idea = fixture(:idea, user)
    {:ok, idea: idea}
  end
end
