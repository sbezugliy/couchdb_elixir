defmodule Emporium.Backend.ProductController do
  use Emporium.Web, :controller
  #alias Emporium.Backend.Product
  alias Emporium.Product

  def index(conn, _params) do
    products = CouchDB.Repo.all
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)
    case CouchDB.Repo.insert(changeset) do
      %{id: id, ok: _, rev: rev} ->
        conn
        |> put_flash(:info, "Product created successfully. #{id}")
        |> redirect(to: product_path(conn, :index))
      %{error: error, reason: reason} ->
        conn
        |> put_flash(:error, "Error: #{error}. Reason: #{reason}")
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = CouchDB.Repo.read(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    prod_doc = CouchDB.Repo.read(id)
    product = %Product{id: prod_doc[:_id], product: prod_doc[:product], sku: prod_doc[:sku], _rev: prod_doc[:_rev]}
    changeset = Product.changeset(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    prod_doc = CouchDB.Repo.read(id)
    product = %Product{id: prod_doc[:_id], product: prod_doc[:product], sku: prod_doc[:sku], _rev: prod_doc[:_rev]}
    changeset = Product.changeset(product, product_params)
    changeset = Map.put(changeset, "_rev", prod_doc["_rev"])
    case CouchDB.Repo.update(changeset, id, prod_doc[:_rev]) do
      %{id: id, ok: _, rev: rev} ->
        conn
        |> put_flash(:info, "Product updated successfully. #{id}")
        |> redirect(to: product_path(conn, :show, id))
      %{error: error, reason: reason} ->
        conn
        |> put_flash(:error, "Error: #{error}. Reason: #{reason}")
        |> render("edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = CouchDB.Repo.read(id)
    IO.inspect product[:_rev]
    case CouchDB.Repo.delete(id, product[:_rev]) do
      %{id: id, ok: _, rev: rev} ->
        conn
        |> put_flash(:info, "Product deleted successfully.")
        |> redirect(to: product_path(conn, :index))
      %{error: error, reason: reason} ->
        conn
        |> put_flash(:error, "Error: #{error}. Reason: #{reason}")
        |> redirect(to: product_path(conn, :index))
    end
  end
end
