defmodule AuctionWeb.PageController do
  use AuctionWeb, :controller

  def home(conn, _params) do
    items = Auction.list_items()
    render(conn, :home, items: items)
  end

end
