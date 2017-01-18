defmodule GithubHookBotTest.Example.ExampleTest.Client.Neko do
  def neko() do
    1 + 1
  end
end

defmodule GithubHookBotTest.Example.ExampleTest.Client do
  use GithubHookBot.Client.Plug

  alias GithubHookBot.Client.Action
  alias GithubHookBotTest.Example.Client.Sample1

  @repository_name "example/sample1"

  plug GithubHookBotTest.Example.ExampleTest.Client.Neko.neko

  def get_new_comment(%Action{repository: @repository_name} = param) do
    param |> Sample1.response_message()
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
               |> put_in([Access.key!(:repository)], @test_repository)
               |> put_in([Access.key!(:action)], :add_comment)
               |> put_in([Access.key!(:issue_number)], 12345)
               |> put_in([Access.key!(:hook), Access.key!(:repository), Access.key!(:full_name)], @test_repository)
               |> Client.get_new_comment
      {:ok, result} = action
                      |> Action.response
      assert result.comment == "add_comment to 12345, message is hook is arrived in example/sample1"
    end

    test "with created action" do
      action = %Action{}
               |> put_in([Access.key!(:repository)], @test_repository)
               |> put_in([Access.key!(:action)], :add_comment)
               |> put_in([Access.key!(:issue_number)], 12345)
               |> put_in([Access.key!(:hook), Access.key!(:repository), Access.key!(:full_name)], @test_repository)
               |> put_in([Access.key!(:hook), Access.key!(:action)], "created")
               |> Client.get_new_comment
     {:ok, result} = action
                     |> Action.response
      assert result.comment == "add_comment to 12345, message is new issue is created"
    end
  end

  test "get new labels" do
    action = %Action{}
             |> put_in([Access.key!(:repository)], @test_repository)
             |> put_in([Access.key!(:action)], :add_labels)
             |> put_in([Access.key!(:issue_number)], 12345)
             |> put_in([Access.key!(:hook), Access.key!(:repository), Access.key!(:full_name)], @test_repository)
             |> Client.get_new_labels
   {:ok, result} = action
                   |> Action.response

    assert result.labels == ["a", "b", "c"]
  end
end
