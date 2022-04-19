defmodule SchoolWeb.ProtocolView do
  use SchoolWeb, :view

  def render("show.json", %{person: person}) do
    %{
      gender: person.gender,
      address: person.address,
      date_of_birth: person.date_of_birth,
      number_of_courses: person.number_of_courses
    }
  end
end
