defmodule GithubHookBot.Github.Repository.Issue do

  @type t ::%__MODULE__{ number:     integer,
                         event:      String.t,
                         labels:     [String.t],
                         comments:   String.t,
                         milestones: [String.t],
                         assignees:  [String.t],
                       }

  defstruct [
    :number, # issue number
    :event,
    :labels,
    :comments,
    :milestones,
    :assignees
  ]
end
