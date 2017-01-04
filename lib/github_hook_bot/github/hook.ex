defmodule GithubHookBot.Github.Hook do
  @moduledoc """
  Storeing hooked data.
  """

  alias GithubHookBot.Github.Repository

  @doc """
  `:event` is event in X-GitHub-Event.
  `:payload` is Webhook payload.
  `:action` is action why web hook is called. e.g. "created"
  `:repository` is a repository name which send webhook.
  """
  defstruct [
    :event,
    :payload,
    :action,
    repository: %Repository{},
  ]
end
