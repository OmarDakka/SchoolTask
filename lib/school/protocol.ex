alias School.Students.Student
alias School.Teachers.Teacher

defprotocol School.Person do
  def show(person)
end

defimpl School.Person, for: Student do
  def show(student) do
    student
    |> Map.take([:address, :gender, :date_of_birth])
    |> Map.put(
      :number_of_courses,
      student.courses
      |> Enum.filter(fn course -> course.semester == :first end)
      |> length()
    )
  end
end

defimpl School.Person, for: Teacher do
  def show(teacher) do
    teacher
    |> Map.take([:address, :gender, :date_of_birth])
    |> Map.put(:number_of_courses, length(teacher.courses))
  end
end
