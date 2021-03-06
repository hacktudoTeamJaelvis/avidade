defmodule AvidadeWeb.Router do
  use AvidadeWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", AvidadeWeb do
    pipe_through(:api)

    put("/shelves/:id", ShelfController, :update)
  end

  # Other scopes may use custom stacks.
  # scope "/api", AvidadeWeb do
  #   pipe_through :api
  # end
end
