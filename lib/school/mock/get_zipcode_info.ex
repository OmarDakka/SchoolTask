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
end
