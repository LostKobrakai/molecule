defmodule Molecule.MixProject do
  use Mix.Project

  @github "https://github.com/LostKobrakai/molecule"

  def project do
    [
      app: :molecule,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @github,
      name: "Molecule",
      package: package(),
      docs: docs()
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
      {:jason, "~> 1.0", only: :test},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @github}
    ]
  end

  defp docs do
    [
      main: "Molecule"
    ]
  end
end
