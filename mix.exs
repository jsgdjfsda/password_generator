defmodule PasswordGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :password_generator,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
      deps: deps()
    ]
  end

  # Configuration for the escript
  defp escript_config do
    [main_module: PasswordGenerator.CLI]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
