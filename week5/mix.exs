defmodule Week5.MixProject do
  use Mix.Project

  def project do
    [
      app: :week5,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison, :jason, :floki, :tesla, :poison, :httpotion]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.3"},
      {:sweet_xml, "~> 0.7.1"},
      {:floki, "~> 0.34.0"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:poison, "~> 5.0"},
      {:httpotion, "~> 3.1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
