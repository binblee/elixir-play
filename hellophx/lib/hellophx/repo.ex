defmodule Hellophx.Repo do
  use Ecto.Repo,
    otp_app: :hellophx,
    adapter: Ecto.Adapters.Postgres
end
