defmodule Mos.Repo.Migrations.CalendarEvents do
  use Ecto.Migration

  def change do
    create table(:calendar_events) do
      add :calendar_id,          references(:calendars)
      add :identifier,           :string, null: false
      
      add :display_name,         :string,       null: false
      add :teaser,               :text,         null: false
      
      add :startdate,            :utc_datetime, null: false
      add :startdate_utc_offset, :integer,      null: false

      add :enddate,              :utc_datetime, null: false
      add :enddate_utc_offset,   :integer,      null: false
      
      add :properties,           :jsonb,        null: false, default: "{}"

      timestamps()
    end

    create unique_index("calendar_events", [:identifier])
  end
end
