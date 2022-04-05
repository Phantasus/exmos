defmodule Mos.Repo do
  use Ecto.Repo,
    otp_app: :mos,
    adapter: Ecto.Adapters.Postgres
end
