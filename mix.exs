defmodule PasswordGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :password_generator,
      version: "0.1.0",
      elixir: "~> 1.12",
      escript: [main_module: PasswordGenerator.CLI],
      deps: deps(),
      # Add these test-specific configurations
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      # Add ExCoveralls for test coverage reporting
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end
end
