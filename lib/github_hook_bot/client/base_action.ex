defmodule GithubHookBot.Client.BaseAction do

  alias GithubHookBot.Client.Action

  @type param :: %Action{}
  @type result :: %Action{}

  @callback comment_message(param) :: result
  @callback new_labels(param) :: result

  @optional_callbacks comment_message: 1, new_labels: 1
end
