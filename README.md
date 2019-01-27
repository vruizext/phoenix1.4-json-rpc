# JsonRpcApi

This is an simple example of how to setup a [JSON RPC](https://www.jsonrpc.org/specification) API with Phoenix 1.4.

After checking out the project, you can start your Phoenix server as usual:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`


To test the API you have to send a `POST` request to the `/api` endpoint, and include in the payload a valid JSON RPC request.


```
POST /api HTTP/1.1
[{"jsonrpc": "2.0", "method": "hello", "params": {"name": "FooBar"}, "id": 1},
{"jsonrpc": "2.0", "method": "bye", "params": {"name": "John Doe"}, "id": 23}]
```

Yields:

```
[{"id": 1,"jsonrpc": "2.0", "result": {"hello": "FooBar"}},
{"id": 23,"jsonrpc": "2.0", "result": {"bye": "John Doe"}}]
```