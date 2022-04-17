Mox.defmock(GetZipcodeInfoBehaviorMock, for: School.GetZipcodeInfoBehavior)
Application.put_env(:bound, :school, GetZipcodeInfoBehaviorMock)

ExUnit.start()
# Ecto.Adapters.SQL.Sandbox.mode(School.Repo, :manual)
