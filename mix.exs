defmodule GithubHookBot.Mixfile do
  use Mix.Project

  def project do
    [app: :github_hook_bot,
     version: "0.1.0",
     elixir: "~> 1.4-rc",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:plug, "~> 1.3.0"},
      {:poison, "~> 3.0"}
    ]
  end
end
