defmodule IdeacaoWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :ideacao,
    error_handler: IdeacaoWeb.Auth.ErrorHandler,
    module: IdeacaoWeb.Auth.Guardian

  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end