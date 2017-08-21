defmodule CouchDB.Doc do

  @moduledoc """
  Documentation for CouchdbDocs.
  """

  import CouchDB.Env


  @doc """
  Hello world.

  ## Examples

      iex> CouchdbDocs.hello
      :world

  """
  def create(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), dataset) do
    [uuid] = CouchDB.DB.uuid()[:uuids]
    conn
    |> CouchDB.HTTP.put("/" <> db_name <> "/" <> uuid, dataset)
    |> CouchDB.HTTP.Response.parse
  end

  def read(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), uuid) do
    conn
    |> CouchDB.HTTP.get("/" <> db_name <> "/" <> uuid)
    |> CouchDB.HTTP.Response.parse
  end

  def update(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), uuid, dataset) do
    conn
    |> CouchDB.HTTP.put("/" <> db_name <> "/" <> uuid, dataset)
    |> CouchDB.HTTP.Response.parse
  end

  def delete(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), uuid, rev) do
    conn
    |> CouchDB.HTTP.delete("/" <> db_name <> "/" <> uuid, headers: CouchDB.HTTP.Headers.ifmatch(rev))
    |> CouchDB.HTTP.Response.parse
  end

end
