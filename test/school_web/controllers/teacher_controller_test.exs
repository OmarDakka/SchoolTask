defmodule SchoolWeb.TeacherControllerTest do
  use SchoolWeb.ConnCase

  @create_attrs %{
    first_name: "some name",
    last_name: "some last name",
    email: "some@gmail.com"
  }

  describe "index" do
    test "list all teachers", %{conn: conn} do
      conn = get(conn, Routes.teacher_path(conn, :index))

      assert json_response(conn, 200) == %{
               "teachers" => [],
               "page_number" => 1,
               "page_size" => 4,
               "total_entries" => 0,
               "total_pages" => 1
             }
    end
  end

  describe "create" do
    test "renders teacher when data is valid", %{conn: conn} do
      conn = post(conn, Routes.teacher_path(conn, :create), teachers: @create_attrs)
      assert %{"data" => %{"id" => id}} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.teacher_path(conn, :show, id))

      assert %{
               "id" => id,
               "first_name" => "some name",
               "last_name" => "some last name",
               "email" => "some@gmail.com"
             } = json_response(conn, 200)["data"]
    end
  end
end
