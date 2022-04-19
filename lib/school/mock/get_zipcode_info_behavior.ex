defmodule School.GetZipcodeInfoBehavior do
  @callback generate_info(integer()) :: {:ok, map()} | {:ok, binary()} | {:error, binary()}
  @callback create_teacher(any, any, any, any, any, any) ::
              {:error, HTTPoison.Error.t()}
              | {:ok,
                 %{
                   :__struct__ =>
                     HTTPoison.AsyncResponse | HTTPoison.MaybeRedirect | HTTPoison.Response,
                   optional(:body) => any,
                   optional(:headers) => list,
                   optional(:id) => reference,
                   optional(:redirect_url) => any,
                   optional(:request) => HTTPoison.Request.t(),
                   optional(:request_url) => any,
                   optional(:status_code) => integer
                 }}
end
