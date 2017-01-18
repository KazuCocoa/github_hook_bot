defmodule GithubHookBot.Client.BaseAction do

  alias GithubHookBot.Client.Action

  @type param :: %Action{}
  @type result :: %Action{}

  @callback response_message(param) :: result
  @callback new_labels(param) :: result

  @optional_callbacks response_message: 1, new_labels: 1
end


defmodule GithubHookBot.Client.Plug do
  @moduledoc """
  Try to `plug`
  """

  defmacro __using__(_opts) do
    quote do
      import GithubHookBot.Client.Plug, only: [plug: 1, plug: 2]

      Module.register_attribute(__MODULE__, :plugs, accumulate: true)
      @before_compile GithubHookBot.Client.Plug
    end
  end

  defmacro __before_compile__(env) do
    plugs = Module.get_attribute(env.module, :plugs)
    IO.inspect plugs
  end

  defmacro plug(plug, _opts \\ []) do
    quote do
      @plugs unquote(plug)
    end
  end

end
