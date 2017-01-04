defmodule GithubHookBot.Client.Action do

  alias GithubHookBot.Github.Hook
  alias GithubHookBot.Client.Action

  @type action :: :add_comment | :add_labels
  @type t ::%__MODULE__{ action: action,
                         comment: String.t,
                         labels: String.t,
                         repository: String.t,
                         issue_number: integer,
                         hook: %Hook{}
                       }

  @doc """
  Define client's action and related items.

  * `:action` is the client's action.
  * `:comment` is message.
  """
  defstruct [
    :action,
    :comment,
    :labels,
    :repository,   # which repository do you would like to response.
    :issue_number, # which issue number do you would like to response.
    hook: %Hook{}
  ]

  def post(%Action{action: :add_comment, issue_number: issue_number, comment: message}) do
    {:ok, "add_comment to #{issue_number}, message is #{message}"}
  end

  def post(%Action{action: :add_labels}) do
    {:ok, "blank"}
  end
end
