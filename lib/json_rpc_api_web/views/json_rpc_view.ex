defmodule JsonRpcApiWeb.JsonRpcView do
  use JsonRpcApiWeb, :view

  def render("rpc_response.json", %{response: responses}) when is_list(responses) do
    responses
    |> Enum.map(&json_rpc_response/1)
    |> Enum.reject(&is_nil/1)
  end

  def render("rpc_response.json", %{response: response}) when is_tuple(response) do
    json_rpc_response(response)
  end

  def json_rpc_response(response) when is_tuple(response) do
    case response do
      {:ok, {result, id}} ->
        json_rpc_result(result, id)
      {:error, {code, message, id}} ->
        json_rpc_error(code, message, id)
      {:noresponse, nil} ->
        nil
    end
  end

  def json_rpc_result(result, id) do
    %{
      "jsonrpc" => "2.0",
      "result" => result,
      "id" => id
    }
  end

  def json_rpc_error(code, message, id) do
    %{
      "jsonrpc" => "2.0",
      "error" => %{
        "code" => code,
        "message" => message
      },
      "id" => id
    }
  end
end
