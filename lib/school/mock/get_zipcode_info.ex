defmodule School.GetZipcodeInfo do
  alias School.GetZipcodeInfoBehavior
  @behaviour GetZipcodeInfoBehavior

  @impl GetZipcodeInfoBehavior
  @spec generate_info(integer()) :: {:ok, map()} | {:ok, binary()} | {:error, binary()}
  def generate_info(code) do
    url = "https://api.zippopotam.us/us/#{code}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.encode(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Jason.encode("Not found")

      {:error, %HTTPoison.Error{reason: reason}} ->
        Jason.encode(reason)
    end
  end

  @impl GetZipcodeInfoBehavior
  @spec create_teacher(any, any, any, any, any, any) ::
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
  def create_teacher(first_name, last_name, email, gender, address, date_of_birth) do
    url = "http://localhost:4000/api/teachers"

    body =
      Jason.encode!(%{
        teachers: %{
          first_name: first_name,
          last_name: last_name,
          email: email,
          gender: gender,
          address: address,
          date_of_birth: date_of_birth
        }
      })

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, body, headers, [])
  end
end
