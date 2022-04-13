defmodule SchoolWeb.Controllers.ControllerHelper do
  def errors_from_changset(changeset) do
    serializable_errors =
      for {field, {message, _}} <- changeset,
          do: %{"field" => to_string(field), "message" => message}

    %{errors: serializable_errors}
  end
end
