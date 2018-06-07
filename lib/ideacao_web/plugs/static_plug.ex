defmodule IdeacaoWeb.StaticPlug do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(%{request_path: "/api" <> _ } = conn, _) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, ~s({"error": "not found"}))
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "priv/static/index.html")
  end
end
