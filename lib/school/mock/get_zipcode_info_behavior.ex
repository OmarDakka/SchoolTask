defmodule School.GetZipcodeInfoBehavior do
  @callback generate_info(integer()) :: {:ok, map()} | {:ok, binary()} | {:error, binary()}
end
