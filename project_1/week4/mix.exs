defmodule Project1.MixProject do
  use Mix.Project

  def project do
    [
      app: :week2,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jason, :poison, :floki]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:statistics, "~> 0.6.0"},
      {:poison, "~> 5.0"},
      {:jason, "~> 1.3"},
      {:floki, "~> 0.34.0"},
      {:httpoison, "~> 2.0"},
      {:json, "~> 1.4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
