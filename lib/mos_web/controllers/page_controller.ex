defmodule MosWeb.PageController do
  use MosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
