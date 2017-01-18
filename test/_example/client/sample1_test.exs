defmodule GithubHookBotTest.Example.Client.Sample1 do
  @bahaviour GithubHookBot.Client.BaseAction

  alias GithubHookBot.Client.Action
  alias GithubHookBot.Github.{Hook, Repository}

  @repository "example/sample1"

  defstruct [repository_name: @repository]

  def response_message(%Action{hook: %Hook{action: "created"}} = param) do
    param |> put_in([Access.key(:comment, nil)], "new issue is created")
  end
  def response_message(%Action{} = param) do
    param |> put_in([Access.key(:comment, nil)], "hook is arrived in #{@repository}")
  end

  def new_labels(%Action{hook: %Hook{repository: %Repository{full_name: @repository}}} = param) do
    param |> put_in([Access.key(:labels, nil)], ["a", "b", "c"])
  end
end
