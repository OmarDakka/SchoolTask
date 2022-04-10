defmodule SchoolWeb.UserController do
  use SchoolWeb, :controller

  alias School.Users

  def register(conn, %{"users" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        render(conn, "register.json", user: user)

      {:error, error} ->
        json(
          conn,
          Enum.map(error.errors, fn message ->
            {
              field,
              {text, validation}
            } = message

            "field #{field}: #{text} #{inspect(validation)}"
          end)
        )
    end
  end
end
