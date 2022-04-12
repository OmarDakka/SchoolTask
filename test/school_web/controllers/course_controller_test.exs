defmodule SchoolWeb.CourseControllerTest do
  use SchoolWeb.ConnCase

  @create_course %{
    course_name: "some course name",
    code: "some code",
    semester: "one semester",
    teacher_id: "2",
    description: "description"
  }

  describe "index" do
    test "list all courses", %{conn: conn} do
      conn = get(conn, Routes.course_path(conn, :index))

      assert json_response(conn, 200) == %{
               "courses" => [],
               "page_number" => 1,
               "page_size" => 4,
               "total_entries" => 0,
               "total_pages" => 1
             }
    end
  end

  # describe "create" do
  #   test "renders course when data is valid", %{conn: conn} do

  # end
end
