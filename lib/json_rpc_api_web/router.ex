defmodule JsonRpcApiWeb.Router do
  use JsonRpcApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", JsonRpcApiWeb do
    pipe_through :api
    post "/", JsonRpcController, :handle
  end
end
