defmodule HellophxWeb.Router do
  use HellophxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HellophxWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HellophxWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Form, :new
    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/edit", PostLive.Form, :edit
  end

  scope "/api", HellophxWeb do
    pipe_through :api
    resources "/urls", UrlController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hellophx, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HellophxWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
