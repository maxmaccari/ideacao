defmodule Ideacao.IdeasTest do
  use Ideacao.DataCase

  alias Ideacao.Ideas

  @user_attrs %{name: "User Test", email: "user@example.com", password: "123456", password_confirmation: "123456"}

  setup do
    {:ok, user} = Ideacao.Accounts.create_user(@user_attrs)

    [user: user]
  end

  describe "ideas" do
    alias Ideacao.Ideas.Idea

    @valid_attrs %{description: "some description", name: "some name", problem: "some problem", target: "some target"}
    @update_attrs %{description: "some updated description", name: "some updated name", problem: "some updated problem", target: "some updated target"}
    @invalid_attrs %{description: nil, name: nil, problem: nil, target: nil}

    def idea_fixture(attrs \\ %{}) do
      {:ok, idea} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ideas.create_idea()

      idea
    end

    test "list_ideas/0 returns all ideas", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert Ideas.list_ideas() == [idea]
    end

    test "get_idea!/1 returns the idea with given id", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert Ideas.get_idea!(idea.id) == idea
    end

    test "create_idea/1 with valid data creates a idea", %{user: user} do
      valid_attrs = Map.put(@valid_attrs, :author_id, user.id)
      assert {:ok, %Idea{} = idea} = Ideas.create_idea(valid_attrs)
      assert idea.description == "some description"
      assert idea.name == "some name"
      assert idea.problem == "some problem"
      assert idea.target == "some target"
    end

    test "create_idea/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ideas.create_idea(@invalid_attrs)
    end

    test "update_idea/2 with valid data updates the idea", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert {:ok, idea} = Ideas.update_idea(idea, @update_attrs)
      assert %Idea{} = idea
      assert idea.description == "some updated description"
      assert idea.name == "some updated name"
      assert idea.problem == "some updated problem"
      assert idea.target == "some updated target"
    end

    test "update_idea/2 with invalid data returns error changeset", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert {:error, %Ecto.Changeset{}} = Ideas.update_idea(idea, @invalid_attrs)
      assert idea == Ideas.get_idea!(idea.id)
    end

    test "delete_idea/1 deletes the idea", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert {:ok, %Idea{}} = Ideas.delete_idea(idea)
      assert_raise Ecto.NoResultsError, fn -> Ideas.get_idea!(idea.id) end
    end

    test "change_idea/1 returns a idea changeset", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      assert %Ecto.Changeset{} = Ideas.change_idea(idea)
    end
  end

  describe "feedbacks" do
    alias Ideacao.Ideas.Feedback

    @valid_attrs %{comment: "some comment", rate: 6}
    @update_attrs %{comment: "some updated comment", rate: 7}
    @invalid_attrs %{comment: nil, rate: -1}

    def feedback_fixture(attrs \\ %{}) do
      {:ok, feedback} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ideas.create_feedback()

      feedback
    end

    test "list_feedbacks/0 returns all feedbacks", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert Ideas.list_feedbacks() == [feedback]
    end

    test "list_feedbacks/1 returns all feedbacks from an idea", %{user: user} do
      idea1 = idea_fixture(author_id: user.id)
      idea2 = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea1.id)
      assert Ideas.list_feedbacks(idea1) == [feedback]
      assert Ideas.list_feedbacks(idea2) == []
    end

    test "get_feedback!/1 returns the feedback with given id", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert Ideas.get_feedback!(feedback.id) == feedback
    end

    test "get_feedback!/2 returns the feedback with given id from an idea", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert Ideas.get_feedback!(idea, feedback.id) == feedback
    end

    test "create_feedback/1 with valid data creates a feedback", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      valid_attrs = Map.merge(@valid_attrs, %{user_id: user.id, idea_id: idea.id})
      assert {:ok, %Feedback{} = feedback} = Ideas.create_feedback(valid_attrs)
      assert feedback.comment == "some comment"
      assert feedback.rate == 6
    end

    test "create_feedback/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ideas.create_feedback(@invalid_attrs)
    end

    test "update_feedback/2 with valid data updates the feedback", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert {:ok, feedback} = Ideas.update_feedback(feedback, @update_attrs)
      assert %Feedback{} = feedback
      assert feedback.comment == "some updated comment"
      assert feedback.rate == 7
    end

    test "update_feedback/2 with invalid data returns error changeset", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert {:error, %Ecto.Changeset{}} = Ideas.update_feedback(feedback, @invalid_attrs)
      assert feedback == Ideas.get_feedback!(feedback.id)
    end

    test "delete_feedback/1 deletes the feedback", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert {:ok, %Feedback{}} = Ideas.delete_feedback(feedback)
      assert_raise Ecto.NoResultsError, fn -> Ideas.get_feedback!(feedback.id) end
    end

    test "change_feedback/1 returns a feedback changeset", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert %Ecto.Changeset{} = Ideas.change_feedback(feedback)
    end

    test "preload_user/1 preloads user from a query", %{user: user} do
      idea = idea_fixture(author_id: user.id)
      feedback = feedback_fixture(user_id: user.id, idea_id: idea.id)
      assert %Ideacao.Accounts.User{} = Ideas.preload_user(feedback).user
    end
  end
end
