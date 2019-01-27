defmodule JsonRpcApi.JsonRpcErrors do
  def error_code_and_message(:parse_error), do: {-32700, "Parse error"}
  def error_code_and_message(:invalid_request), do: {-32600, "Invalid Request"}
  def error_code_and_message(:method_not_found), do: {-32601, "Method not found"}
  def error_code_and_message(:invalid_params), do: {-32602, "Invalid params"}
  def error_code_and_message(:internal_error), do: {-32603, "Internal error"}
  def error_code_and_message(:server_error), do: {-32000, "Server error"}
end
