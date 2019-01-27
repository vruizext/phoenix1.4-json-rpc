defmodule JsonRpcApi.JsonRpcMethods do
  def hello(%{"name" => name} = _params) do
    %{hello: name}
  end

  def bye(%{"name" => name} = _params) do
    %{bye: name}
  end
end
