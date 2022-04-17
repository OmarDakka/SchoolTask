defmodule BoundTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  describe "get_info/1" do
    test "fetches info of location based on zipcode" do
      expect(GetZipcodeInfoBehaviorMock, :generate_info, fn args ->
        assert args == 46755

        {:ok, %{body: "json with location data"}}
      end)

      assert {:ok, _} = School.Bound.generate_info(46755)
    end
  end
end
