defmodule CouchDB.DB do
  @moduledoc """
  Documentation for CouchdbDbs.
  """


  @doc """
  Hello world.

  ## Examples

      iex> CouchdbDbs.hello
      :world

  """

  def all_dbs(conn \\ CouchDB.HTTP.client) do
    conn
    |> CouchDB.HTTP.get("/_all_dbs")
    |> CouchDB.HTTP.Response.parse
  end

  def create(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.put("/" <> db_name, "", headers: CouchDB.HTTP.Headers.content_type(:json))
    |> CouchDB.HTTP.Response.parse
  end

  def delete(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.delete("/" <> db_name)
    |> CouchDB.HTTP.Response.parse
  end

  def info(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.get("/" <> db_name)
    |> CouchDB.HTTP.Response.parse
  end

  def exist?(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.head("/" <> db_name)
    |> CouchDB.HTTP.Response.parse
  end

  def all_docs(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.get("/" <> db_name <> "/_all_docs")
    |> CouchDB.HTTP.Response.parse
  end

  # ToDo: format rows to an JSON array
  def rows_from_docs(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), rows) do
    conn
    |> CouchDB.HTTP.post("/" <> db_name <> "/_all_docs", "", headers: CouchDB.HTTP.Headers.content_type(:json))
    |> CouchDB.HTTP.Response.parse
  end

  def changes(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name()) do
    conn
    |> CouchDB.HTTP.get("/" <> db_name <> "/_changes")
    |> CouchDB.HTTP.Response.parse
  end

  # ToDo: format docs to an JSON array
  def changes_of_docs(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name(), docs) do

    conn
    |> CouchDB.HTTP.post("/" <> db_name <> "/_changes", "", headers: CouchDB.HTTP.Headers.content_type(:json))
    |> CouchDB.HTTP.Response.parse
  end

  def uuid(conn \\ CouchDB.HTTP.client, count \\ 1) do
    conn
    |> CouchDB.HTTP.get("/_uuids?count=#{count}")
    |> CouchDB.HTTP.Response.parse
  end

  def active_tasks(conn \\ CouchDB.HTTP.client) do
    conn
    |> CouchDB.HTTP.get("/_active_tasks")
    |> CouchDB.HTTP.Response.parse
  end

  def membership(conn \\ CouchDB.HTTP.client) do
    conn
    |> CouchDB.HTTP.get("/_membership")
    |> CouchDB.HTTP.Response.parse
  end

  def stats(conn \\ CouchDB.HTTP.client, section \\ "") do
    conn
    |> CouchDB.HTTP.get("/_stats" <> section)
    |> CouchDB.HTTP.Response.parse
  end

  def restart(conn \\ CouchDB.HTTP.client) do
    conn
    |> CouchDB.HTTP.get("/_restart")
    |> CouchDB.HTTP.Response.parse
  end

  def replicate(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name, target, continuous \\ false, create_target \\ true) do
    data = "{"
    if continuous do
      data = data <> "\"continuous\": #{continuous}"
    end
    if create_target do
      data = data <> "\"create_target\": #{create_target}"
    end
    data = data <> "\"source\": \"#{db_name}\", \"target\": \"#{target}\"}"
    conn
    |> CouchDB.HTTP.post("/_replicate", data, headers: CouchDB.HTTP.Headers.content_type(:json))
    |> CouchDB.HTTP.Response.parse
  end

  def cancel_replication(conn \\ CouchDB.HTTP.client, db_name \\ CouchDB.Env.db_name, target, continuous \\ false, create_target \\ true) do
    data = "{"
    if continuous do
      data = data <> "\"continuous\": #{continuous},"
    end
    if create_target do
      data = data <> "\"create_target\": #{create_target},"
    end
    data = data <> "\"source\": \"#{db_name}\", \"target\": \"#{target}\", \"cancel\": true }"
    conn
    |> CouchDB.HTTP.post("/_replicate", data, headers: CouchDB.HTTP.Headers.content_type(:json))
    |> CouchDB.HTTP.Response.parse
  end

end
