defmodule GithubHookBot.Client.Action do

  alias GithubHookBot.Github.Hook

  defstruct [
    :action,
    :comment,
    :labels,
    :repository,   # which repository do you would like to response.
    :issue_number, # which issue number do you would like to response.
    hook: %Hook{}
  ]
end
