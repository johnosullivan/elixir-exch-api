defmodule MyAPIWeb.Router do
  use MyAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyAPIWeb do
    pipe_through :api
  end
end
