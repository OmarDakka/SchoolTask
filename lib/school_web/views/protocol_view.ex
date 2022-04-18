defmodule SchoolWeb.ProtocolView do
  use SchoolWeb, :view

  def render("show.json", %{data: data}) do
    %{person: person, number_of_courses: number_of_courses} = data

    %{
      gender: person.gender,
      address: person.address,
      date_of_birth: person.date_of_birth,
      number_of_courses: number_of_courses
    }
  end
end
