defmodule School.Bound do
  def generate_info(code) do
    zipcode_impl().generate_info(code)
  end

  def create_teacher(first_name, last_name, email, gender, address, date_of_birth) do
    zipcode_impl().create_teacher(first_name, last_name, email, gender, address, date_of_birth)
  end

  def zipcode_impl() do
    Application.get_env(:bound, :school, School.GetZipcodeInfo)
  end
end
