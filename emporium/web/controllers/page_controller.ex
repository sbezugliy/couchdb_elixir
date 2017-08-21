defmodule Emporium.PageController do
  use Emporium.Web, :controller

  plug :put_layout, "splash.html"

  def index(conn, _params) do
    docs =CouchDB.Repo.all
    render conn, "index.html", docs: docs
  end
end
