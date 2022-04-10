defmodule School.StudentCourse.StudentsCourses do
  use Ecto.Schema

  alias School.Courses.Course
  alias School.Students.Student

  schema "students_courses" do
    belongs_to :student, Student
    belongs_to :course, Course

    timestamps()
  end
end
