# AuctionWeb

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix

## phx.new todos

```
mix phx.new.web auction_web --no-ecto

...

We are almost there! The following steps are missing:

    $ cd auction_web

Your web app requires a PubSub server to be running.
The PubSub server is typically defined in a `mix phx.new.ecto` app.
If you don't plan to define an Ecto app, you must explicitly start
the PubSub in your supervision tree as:

    {Phoenix.PubSub, name: AuctionWeb.PubSub}

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server
```
To start PubSub, add an entry in [lib/auction_web/application.ex](lib/auction_web/application.ex)

```elixir
  def start(_type, _args) do
    children = [
      AuctionWeb.Telemetry,
      # Start a worker by calling: AuctionWeb.Worker.start_link(arg)
      # {AuctionWeb.Worker, arg},
      # Start the PubSub system (added manually if --no-ecto was used)
      {Phoenix.PubSub, name: AuctionWeb.PubSub},
      # Start to serve requests, typically the last entry
      AuctionWeb.Endpoint
    ]
```