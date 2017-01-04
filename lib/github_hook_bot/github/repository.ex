defmodule GithubHookBot.Github.Repository do
  @moduledoc """
  About repository.

  "repo" attributes exists in most of webhook's payload.
  """

  alias GithubHookBot.Github.Repository.Issue

  @type t ::%__MODULE__{ id:        integer,
                         name:      String.t,
                         full_name: String.t,
                         url:       String.t,
                         http_url:  String.t,
                         issue:     %Issue{}
                       }

  defstruct [
    :id,            # 1234
    :name,          # "Hello-World",
    :full_name,     # "octocat/Hello-World"
    :url,           # "https://api.github.com/repos/octocat/Hello-World"
    :http_url,      # "https://github.com/repos/octocat/Hello-World"
    issue: %Issue{}
  ]
end
