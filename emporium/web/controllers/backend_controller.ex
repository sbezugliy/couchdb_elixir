defmodule Emporium.BackendController do
  use Emporium.Web, :controller

  alias Emporium.Backend

  def index(conn, _params) do
    backend = %{}
    render(conn, "index.html", backend: backend)
  end


end
