defmodule Mos.Repo.Migrations.CreateCalendars do
  use Ecto.Migration

  def change do
    create table(:calendars) do
      add :identifier,   :string, null: false
      add :display_name, :string, null: false
      add :properties,   :jsonb,  null: false, default: "{}"

      timestamps()
    end
  end
end
