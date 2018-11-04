defmodule AvidadeWeb.PageController do
  use AvidadeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
