defmodule Emporium.Router do
  use Emporium.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Emporium do
    pipe_through :browser # Use the default browser stack

    get     "/",                          PageController,              :index
    get     "/admin",                     BackendController,           :index
    get     "/admin/products",            Backend.ProductController,   :index
    get     "/admin/products/:id/edit",   Backend.ProductController,   :edit
    get     "/admin/products/new",        Backend.ProductController,   :new
    get     "/admin/products/:id",        Backend.ProductController,   :show
    patch   "/admin/products/:id",        Backend.ProductController,   :update
    put     "/admin/products/:id",        Backend.ProductController,   :update
    post    "/admin/products/:id",        Backend.ProductController,   :update
    post    "/admin/products",            Backend.ProductController,   :create
    delete  "/admin/products/:id",        Backend.ProductController,   :delete

    #resources "/admin/products", Backend.ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CouchdbPhoenix do
  #   pipe_through :api
  # end
end
