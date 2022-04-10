defmodule SchoolWeb.Router do
  use SchoolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SchoolWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug School.Authentication.Guardian.AuthPipeline
  end

  scope "/", SchoolWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", SchoolWeb do
    pipe_through :api

    post "/users", UserController, :register
    post "/sessions/new", SessionController, :new
  end

  scope "/api", SchoolWeb do
    pipe_through [:api, :auth]

    post "/session/refresh", SessionController, :refresh
    post "/session/delete", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api", SchoolWeb do
    pipe_through [:api]

    get "/teachers", TeacherController, :index
    post "/teachers", TeacherController, :create
    get "/teachers/:id", TeacherController, :show
    put "/teachers/:id", TeacherController, :update
    delete "/teachers/:id", TeacherController, :delete
    get "/teachers/:id/courses", TeacherController, :show_multiple
    get "/teachers/:id/students", TeacherController, :show_students

    get "/students", StudentController, :index
    post "/students", StudentController, :create
    get "/students/:id", StudentController, :show
    put "/students/:id", StudentController, :update
    delete "/students/:id", StudentController, :delete
    get "/students/:student_id/courses/:course_id", StudentController, :sign_up

    get "/courses", CourseController, :index
    post "/courses", CourseController, :create
    get "/courses/:id", CourseController, :show
    put "/courses/:id", CourseController, :update
    delete "/courses/:id", CourseController, :delete
    get "/courses/:id/students", CourseController, :get_course_students
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SchoolWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
