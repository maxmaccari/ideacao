defmodule IdeacaoWeb.FeedbackControllerTest do
  use IdeacaoWeb.ConnCase

  alias Ideacao.{Ideas, Accounts}
  alias Ideacao.Ideas.Feedback

  @idea_attrs %{description: "some description", name: "some name", problem: "some problem", target: "some target"}
  @create_attrs %{comment: "some comment", rate: 6}
  @update_attrs %{comment: "some updated comment", rate: 7}
  @invalid_attrs %{comment: nil, rate: -1}

  def fixture(:user) do
    timestamp = :os.system_time(:micro_seconds)
    {:ok, user} = Accounts.create_user %{name: "User Test", email: "user#{timestamp}@example.com"}
    user
  end

  def fixture(:idea, user) do
    create_attrs = Map.put(@idea_attrs, :author_id, user.id)
    {:ok, idea} = Ideas.create_idea(create_attrs)
    idea
  end

  def fixture(:feedback, user, idea) do
    create_attrs = Map.merge(@create_attrs, %{user_id: user.id, idea_id: idea.id})
    {:ok, feedback} = Ideas.create_feedback(create_attrs)
    feedback
  end

  setup %{conn: conn} do
    user = fixture(:user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, idea: fixture(:idea, user)}
  end

  describe "index" do
    test "lists all feedbacks", %{conn: conn} do
      conn = get conn, feedback_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feedback" do
    test "renders feedback when data is valid", %{conn: conn, user: user, idea: idea} do
      create_attrs = Map.merge(@create_attrs, %{user_id: user.id, idea_id: idea.id})
      conn = post conn, feedback_path(conn, :create), feedback: create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, feedback_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some comment",
        "rate" => 6}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, feedback_path(conn, :create), feedback: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feedback" do
    setup [:create_feedback]

    test "renders feedback when data is valid", %{conn: conn, feedback: %Feedback{id: id} = feedback} do
      conn = put conn, feedback_path(conn, :update, feedback), feedback: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, feedback_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some updated comment",
        "rate" => 7}
    end

    test "renders errors when data is invalid", %{conn: conn, feedback: feedback} do
      conn = put conn, feedback_path(conn, :update, feedback), feedback: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete feedback" do
    setup [:create_feedback]

    test "deletes chosen feedback", %{conn: conn, feedback: feedback} do
      conn = delete conn, feedback_path(conn, :delete, feedback)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, feedback_path(conn, :show, feedback)
      end
    end
  end

  defp create_feedback(_) do
    user = fixture(:user)
    idea = fixture(:idea, user)
    feedback = fixture(:feedback, user, idea)
    {:ok, feedback: feedback}
  end
end
