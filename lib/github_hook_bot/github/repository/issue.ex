defmodule GithubHookBot.Github.Repository.Issue do
  defstruct [
    :number, # issue number
    :events,
    :labels,
    :comments,
    :milestones,
    :assignees
  ]
end
