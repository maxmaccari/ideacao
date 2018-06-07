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
    {:ok, user} = Accounts.create_user %{name: "User Test", email: "user#{timestamp}@example.com",
                                         password: "123456", password_confirmation: "123456"}

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
    {:ok, token, _} = IdeacaoWeb.Auth.Guardian.encode_and_sign(user)

    conn = conn
      |> put_req_header("accept", "application/json")
      |> put_auth_token(token)

    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user, idea: fixture(:idea, user),
          token: token}
  end

  describe "index" do
    test "lists all feedbacks from an idea", %{conn: conn, idea: idea} do
      conn = get conn, idea_feedback_path(conn, :index, idea.id)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create feedback" do
    test "renders feedback when data is valid", %{conn: conn, idea: idea, token: token, user: user} do
      conn = post conn, idea_feedback_path(conn, :create, idea.id), feedback: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get authenticated_conn(token), idea_feedback_path(conn, :show, idea.id, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some comment",
        "rate" => 6,
        "user" => %{
          "name" => user.name
        }}
    end

    test "renders errors when data is invalid", %{conn: conn, idea: idea} do
      conn = post conn, idea_feedback_path(conn, :create, idea.id), feedback: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update feedback" do
    setup [:create_feedback]

    test "renders feedback when data is valid", %{conn: conn, feedback: %Feedback{id: id} = feedback, user: user,
                                                  idea: idea, token: token} do
      conn = put conn, idea_feedback_path(conn, :update, idea, feedback), feedback: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get authenticated_conn(token), idea_feedback_path(conn, :show, idea.id, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "comment" => "some updated comment",
        "rate" => 7,
        "user" => %{"name" => user.name}}
    end

    test "renders errors when data is invalid", %{conn: conn, feedback: feedback, idea: idea} do
      conn = put conn, idea_feedback_path(conn, :update, idea, feedback), feedback: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "cannot update another user feedback", %{conn: conn, idea: idea} do
      user = fixture(:user)
      feedback = fixture(:feedback, user, idea)

      conn = put conn, idea_feedback_path(conn, :update, idea, feedback), feedback: @update_attrs

      assert json_response(conn, 401)["errors"] != %{}
      assert Ideas.get_feedback!(feedback.id) == feedback
    end
  end

  describe "delete feedback" do
    setup [:create_feedback]

    test "deletes chosen feedback", %{conn: conn, feedback: feedback, idea: idea, token: token} do
      conn = delete conn, idea_feedback_path(conn, :delete, idea, feedback)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get authenticated_conn(token), idea_feedback_path(conn, :show, idea, feedback)
      end
    end

    test "cannot delete another user feedback", %{conn: conn, idea: idea} do
      user = fixture(:user)
      feedback = fixture(:feedback, user, idea)

      conn = delete conn, idea_feedback_path(conn, :delete, idea, feedback)
      assert json_response(conn, 401)["errors"] != %{}
      assert Ideas.get_feedback!(feedback.id) == feedback
    end
  end

  defp create_feedback(%{user: user, idea: idea}) do
    feedback = fixture(:feedback, user, idea)

    {:ok, feedback: feedback}
  end
end
