defmodule School.Bound do
  def generate_info(code) do
    zipcode_impl().generate_info(code)
  end

  def zipcode_impl() do
    Application.get_env(:bound, :school, School.GetZipcodeInfo)
  end
end
