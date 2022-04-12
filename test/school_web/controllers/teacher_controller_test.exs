defmodule SchoolWeb.TeacherControllerTest do
  use SchoolWeb.ConnCase

  @create_attrs %{
    first_name: "some name",
    last_name: "some last name",
    email: "some@gmail.com"
  }

  @create_course %{
    course_name: "some course name",
    code: "some code",
    semester: "one semester",
    teacher_id: "15",
    description: "description"
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
      assert %{"data" => %{"id" => teacher_id}} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.teacher_path(conn, :show, teacher_id))
      IO.inspect(conn)

      assert %{
               "id" => teacher_id,
               "first_name" => "some name",
               "last_name" => "some last name",
               "email" => "some@gmail.com"
             } = json_response(conn, 200)["data"]

      conn = post(conn, Routes.course_path(conn, :create), course: @create_course)
      assert %{"data" => %{"id" => course_id}} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.course_path(conn, :show, course_id))

      assert %{
               "id" => course_id,
               "course_name" => "some course name",
               "code" => "some code",
               "semester" => "one semester",
               "description" => "description",
               "teacher_id" => teacher_id
             } = json_response(conn, 200)["data"]
    end
  end
end
