defmodule Dotmap.MixProject do
  use Mix.Project

  def project do
    [
      app: :dotmap,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    A module for handling conversions of maps into dot notation and vice versa.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Matthew Sells"],
      links: %{"GitHub" => "https://github.com/mattiebear/dotmap"}
    ]
  end
end
