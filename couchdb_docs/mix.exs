defmodule CouchDB.Doc.Mixfile do
  use Mix.Project

  def project do
    [app: :couchdb_docs,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     description: description(),
     source: "https://github.com/sbezugliy/couchdb_docs.git",
     deps: deps(),
     dialyzer: [plt_add_apps: [:poison],
     plt_add_deps: :project]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end


  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    path_to_workdir = "/home/sergey/workspace/elixir/couchdb_elixir/"
    [
      {:couchdb_auth, path: path_to_workdir <> "couchdb_auth"},
      {:couchdb_dbs, path: path_to_workdir <> "couchdb_dbs"}
    ]
  end

  defp description do
    """
    WIP!
    CouchDB wrapper/framework documents module for Elixir and Phoenix.
    """
  end

  defp package do
      [
        files: ["lib", "mix.exs", "README*", "LICENSE*"],
        maintainers: ["Sergey Bezugliy"],
        licenses: ["Apache 2.0"],
        links: %{"GitHub" => "https://github.com/sbezugliy/couchdb_docs"}
      ]
    end

end
