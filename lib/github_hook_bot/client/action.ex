defmodule GithubHookBot.Client.Action do

  alias GithubHookBot.Github.Hook
  alias GithubHookBot.Client.Action

  @type action :: :add_comment | :add_labels
  @type t ::%__MODULE__{ action: action,
                         comment: String.t,
                         labels: [String.t],
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

  @spec response(t) :: t
  def response(%Action{action: :add_comment, issue_number: issue_number, comment: message} = params) do
    comment = "add_comment to #{issue_number}, message is #{message}"
    new_params = params
                 |> Map.put(:comment, comment)
    {:ok, new_params}
  end

  def response(%Action{action: :add_labels} = params) do
    labels = ["a", "b", "c"]
    new_params = params
                 |> Map.put(:labels, labels)
    {:ok, new_params}
  end
end
