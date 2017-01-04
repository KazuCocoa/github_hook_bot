defmodule GithubHookBotTest.Example.ExampleTest.Client do
  alias GithubHookBot.Client.Action

  alias GithubHookBotTest.Example.Client.Sample1

  @repository_name "example/sample1"

  def get_new_comment(%Action{repository: @repository_name} = param) do
    param |> Sample1.comment_message()
  end

  def get_new_labels(%Action{repository: @repository_name} = param) do
    param |> Sample1.new_labels()
  end
end

defmodule GithubHookBotTest.Example.ExampleTest do
  use ExUnit.Case

  alias GithubHookBot.Client.Action
  alias GithubHookBotTest.Example.ExampleTest.Client

  @test_repository "example/sample1"

  describe "get new message" do
    test "without created action" do
      action = %Action{}
               |> put_in([Access.key(:repository)], @test_repository)
               |> put_in([Access.key(:hook), Access.key(:repository), Access.key(:full_name)], @test_repository)
      result = action
               |> Client.get_new_comment

      assert result.comment == "hook is arrived in #{@test_repository}"
    end

    test "with created action" do
      action = %Action{}
               |> put_in([Access.key(:repository)], @test_repository)
               |> put_in([Access.key(:hook), Access.key(:repository), Access.key(:full_name)], @test_repository)
               |> put_in([Access.key(:hook), Access.key(:action)], "created")
      result = action
               |> Client.get_new_comment

      assert result.comment == "new issue is created"
    end
  end

  test "get new labels" do
    action = %Action{}
             |> put_in([Access.key(:repository)], @test_repository)
             |> put_in([Access.key(:hook), Access.key(:repository), Access.key(:full_name)], @test_repository)
    result = action
             |> Client.get_new_labels

    assert result.labels == ["a", "b", "c"]
  end
end
