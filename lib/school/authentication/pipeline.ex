defmodule School.Authentication.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :school,
    module: School.Guardian,
    error_handler: School.Authentication.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, claims: @claims, scheme: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
