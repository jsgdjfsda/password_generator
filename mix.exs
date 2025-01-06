defmodule PasswordGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :password_generator,
      version: "0.1.0",
      elixir: "~> 1.12",
      escript: [main_module: PasswordGenerator.CLI],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
