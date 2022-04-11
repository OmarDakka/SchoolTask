defmodule SchoolWeb.CourseControllerTest do
  use SchoolWeb.ConnCase

  @create_course %{
    course_name: "hola",
    code: "B77",
    semester: "Second Semester",
    teacher_id: "2",
    description: "que"
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
  #     conn = post(conn, Routes.course_path(conn, :create), course: @create_course)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.course_path(conn, :show, id))

  #     assert %{
  #              "id" => id,
  #              "course_name" => "some course name",
  #              "code" => "some code",
  #              "semester" => "one semester",
  #              "description" => "description",
  #              "teacher_id" => "1"
  #            } = json_response(conn, 200)["data"]
  #   end
  # end
end
