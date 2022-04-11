defmodule SchoolWeb.SessionController do
  use SchoolWeb, :controller

  alias School.Users
  alias School.Guardian

  action_fallback SchoolWeb.FallbackController

  def new(conn, %{"username" => username, "password" => password}) do
    case Users.authenticate_user(username, password) do
      {:ok, user} ->
        {:ok, access_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {15, :minute})

        {:ok, _refresh_token, _claims} =
          Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {7, :day})

        conn
        |> put_resp_cookie("ruid", access_token)
        |> put_status(:created)
        |> render("token.json", access_token: access_token)

      {:error, :invalid_credentials} ->
        body = Jason.encode!(%{error: "unauthorized"})

        conn
        |> send_resp(401, body)
    end
  end

  def refresh(conn, _params) do
    refresh_token =
      Plug.Conn.fetch_cookies(conn) |> Map.from_struct() |> get_in([:cookies, "ruid"])

    IO.inspect(conn)
    IO.inspect(refresh_token)

    case Guardian.exchange(refresh_token, "access", "refresh") do
      {:ok, _old_stuff, {new_access_token, _new_claims}} ->
        conn
        |> put_status(:created)
        |> render("token.json", %{access_token: new_access_token})

      {:error, _reason} ->
        body = Jason.encode!(%{error: "unauthorized"})

        conn
        |> send_resp(401, body)
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_resp_cookie("ruid")
    |> put_status(200)
    |> IO.inspect()
    |> text("Log out successfull")
  end
end
