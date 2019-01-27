defmodule JsonRpcApi.Repo do
  use Ecto.Repo,
    otp_app: :json_rpc_api,
    adapter: Ecto.Adapters.Postgres
end
