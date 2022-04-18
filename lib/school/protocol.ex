alias School.Students.Student
alias School.Teachers.Teacher
alias School.Repo

defprotocol School.Person do
  def show(person)
end

defimpl School.Person, for: Student do
  def show(student) do
    student.courses
    |> Enum.filter(fn course -> course.semester == :first end)
    |> length()
  end
end

defimpl School.Person, for: Teacher do
  def show(teacher) do
    teacher = Repo.preload(teacher, :courses)

    teacher.courses
    |> length()
  end
end
