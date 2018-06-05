defmodule Ideacao.IdeasTest do
  use Ideacao.DataCase

  alias Ideacao.Ideas

  setup do
    {:ok, user} = Ideacao.Accounts.create_user %{name: "User Test", email: "user@example.com"}

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
end
