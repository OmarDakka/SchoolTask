defmodule School.Guardian do
  use Guardian, otp_app: :school
  alias School.Users

  @spec subject_for_token(atom | %{:id => any, optional(any) => any}, any) :: {:ok, binary}
  def subject_for_token(resource, _claim) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Users.get_user(id)
    {:ok, resource}
  end
end
