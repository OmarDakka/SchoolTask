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

  test "tries to fetch info but returns an error" do
    expect(GetZipcodeInfoBehaviorMock, :generate_info, fn args ->
      assert args == nil

      {:ok, %{body: "Not found"}}
    end)

    assert {:ok, %{body: "Not found"}} = School.Bound.generate_info(nil)
  end

  test "testing against the contents of the body of the response" do
    expect(GetZipcodeInfoBehaviorMock, :generate_info, fn args ->
      assert args == 46755

      {:ok,
       %{
         "post code": "46755",
         country: "United States",
         "country abbreviation": "US",
         places: [
           %{
             "place name": "Kendallville",
             longitude: "-85.2609",
             state: "Indiana",
             "state abbreviation": "IN",
             latitude: "41.4482"
           }
         ]
       }}
    end)

    result =
      {:ok,
       %{
         "post code": "46755",
         country: "United States",
         "country abbreviation": "US",
         places: [
           %{
             "place name": "Kendallville",
             longitude: "-85.2609",
             state: "Indiana",
             "state abbreviation": "IN",
             latitude: "41.4482"
           }
         ]
       }}

    assert result = School.Bound.generate_info(46755)
  end

  describe "create_teacher/6" do
    test "creates a teacher based on params passed" do
      expect(GetZipcodeInfoBehaviorMock, :create_teacher, fn first_name,
                                                             last_name,
                                                             email,
                                                             gender,
                                                             address,
                                                             date_of_birth ->
        assert first_name == "omar"
        assert last_name == "daqah"
        assert email == "omar@gmail.com"
        assert gender == "male"
        assert address == "ramallah"
        assert date_of_birth == "1997-09-04"

        {:ok, %{body: "body"}}
      end)

      assert {:ok, %{body: "body"}} =
               School.Bound.create_teacher(
                 "omar",
                 "daqah",
                 "omar@gmail.com",
                 "male",
                 "ramallah",
                 "1997-09-04"
               )
    end
  end
end
