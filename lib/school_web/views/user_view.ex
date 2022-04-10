defmodule SchoolWeb.UserView do
  use SchoolWeb, :view

  def render("register.json", %{user: user}) do
    %{
      username: user.username,
      password: user.password
    }
  end
end
