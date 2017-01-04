defmodule GithubHookBot.Github.Hook do
  @moduledoc """
  Storeing hooked data.
  """

  alias Plug.Conn
  alias GithubHookBot.Github.{Hook, Repository}

  @type conn :: Conn.__struct__

  @type t ::%__MODULE__{ event:      String.t,
                         payload:    map,
                         action:     String.t,
                         repository: %Repository{}
                       }

  @doc """
  Define struct associated with Webhook.

  * `:event` is event in X-GitHub-Event.
  * `:payload` is Webhook payload.
  * `:action` is action why web hook is called. e.g. "created"
  * `:repository` is a repository name which send webhook.
  """
  defstruct [
    :event,
    :payload,
    :action,
    repository: %Repository{},
  ]

  # TODO: ここにWebhookを受け取った時の構造体への保存処理を入れていく
  @spec received_hook(conn) :: {:ok, Hook.t} | {:error, any}
  def received_hook(conn) do
    case Poison.decode(conn.resp_body) do
      {:ok, json_body} ->
        %__MODULE__{}
        |> Map.put(:event, conn.resp_headers) # for example
        |> Map.put(:payload, json_body)
        |> Map.put(:action, conn.neko)
        |> put_in([Access.key(:repository), Access.key(:full_name)], json_body.repo.full_name)
      {:error, message} ->
        %__MODULE__{}
        |> Map.put(:event, conn.resp_headers)
        |> Map.put(:payload, %{message: message <> ": " <> conn.resp_body})
        |> Map.put(:action, conn.neko)
    end
  end
end
