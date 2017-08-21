defmodule Emporium.Product do
  use Emporium.Web, :model

  @primary_key {:id, :binary_id, autogenerate: false}
  @derive {Phoenix.Param, key: :id}

  schema "products" do
    field :product, :string
    field :sku, :string
    field :_rev, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:product, :sku, :_rev])
    |> validate_required([:product, :sku, :_rev])
  end
end
