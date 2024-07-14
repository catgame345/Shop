defmodule ShopWeb.StoreController do
  use ShopWeb, :controller

  alias Shop.Products

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end
end
