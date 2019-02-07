defmodule JsonRpcApiWeb.JsonRpcController do
  use JsonRpcApiWeb, :controller
  import JsonRpcApi.JsonRpcErrors

  alias JsonRpcApi.JsonRpcMethods

  def handle(conn, rpc_request) do
    response =
      rpc_request
      |> parse()
      |> dispatch()
    render(conn, "rpc_response.json", response: response)
  end

  defp dispatch(requests) when is_list(requests) do
    Enum.map(requests, &dispatch(&1))
  end

  defp dispatch({:ok, {method, params, id}}) do
    with_result(apply(JsonRpcMethods, String.to_atom(method), [params]), id)
  rescue
    e in FunctionClauseError ->
      IO.inspect(e)
      with_error(:method_not_found, id)
  catch
    e ->
      IO.inspect(e)
      with_error(:internal_error, id)
  end

  defp dispatch({:error, {error_code, id}}) do
    with_error(error_code, id)
  end

  defp parse(%{"_json" => requests}) do
    for request <- requests, do: parse(request)
  end

  defp parse(request) when is_map(request) do
    IO.inspect(request)
    version = Map.get(request, "jsonrpc", nil)
    method = Map.get(request, "method", nil)
    params = Map.get(request, "params", [])
    id = Map.get(request, "id", nil)

    if valid_request?(version, method, params, id) do
      {:ok, {method, params, id}}
    else
      {:error, {:invalid_request, id}}
    end
  end

  defp valid_request?(version, method, params, id) do
    version == "2.0" && is_binary(method) && (is_list(params) || is_map(params)) &&
      (id == nil || is_binary(id) || is_number(id))
  end

  defp with_result(_result, nil), do: {:noresponse, nil}

  defp with_result(result, id), do: {:ok, {result, id}}

  defp with_error(_error_type, nil), do: {:noresponse, nil}

  defp with_error(error_type, id) do
    {code, message} = error_code_and_message(error_type)
    {:error, {code, message, id}}
  end
end
