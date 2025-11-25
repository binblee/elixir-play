defmodule HellophxWeb.PageController do
  use HellophxWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
