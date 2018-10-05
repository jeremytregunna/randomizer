defmodule Randomizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :randomizer,
      version: "1.0.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19.1", only: :dev},
      {:stream_data, "~> 0.4.2", only: :test}
    ]
  end

  defp package do
    [
      name: :randomizer,
      description: "Generates random strings",
      files: ~w(lib mix.exs README.md LICENSE LICENSE-2.0),
      maintainers: ["Jeremy Tregunna"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/jeremytregunna/randomizer.git",
        "Docs" => "https://hexdocs.pm/randomizer"
      }
    ]
  end
end
