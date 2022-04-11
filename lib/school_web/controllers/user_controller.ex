defmodule SchoolWeb.UserController do
  use SchoolWeb, :controller

  alias School.Users
  alias SchoolWeb.Controllers.ControllerHelper

  def register(conn, %{"users" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        render(conn, "register.json", user: user)

      {:error, error} ->
        conn
        |> put_status(422)
        |> json(ControllerHelper.errors_from_changset(error))
    end
  end
end
