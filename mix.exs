defmodule Molecule.MixProject do
  use Mix.Project

  def project do
    [
      app: :molecule,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:phoenix, "~> 1.5", only: :test},
      {:phoenix_html, "~> 2.14", only: :test},
      {:jason, "~> 1.0", only: :test}
    ]
  end
end
