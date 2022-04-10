defmodule Mos.Repo.Migrations.CalendarEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :identifier,           :string, null: false
      
      add :display_name,         :text, null: false
      add :teaser,               :text, null: false
      add :properties,           :jsonb,   null: false, default: "{}"

      timestamps()
    end

    create table(:event_startdates) do
      add :event_id,             references(:events)
      add :startdate,            :utc_datetime, null: false
      add :startdate_utc_offset, :integer, null: false
      
      timestamps()
    end
    
    create table(:event_enddates) do
      add :event_id,             references(:events)
      add :enddate,              :utc_datetime, null: false
      add :enddate_utc_offset,   :integer, null: false

      timestamps()
    end
      
    create table(:calendar_events) do
      add :identifier,           :string, null: false
      
      add :display_name,         :text, null: false
      add :teaser,               :text, null: false
      add :startdate,            :utc_datetime, null: false
      add :startdate_utc_offset, :integer, null: false
      add :enddate,              :utc_datetime, null: false
      add :enddate_utc_offset,   :integer, null: false
      add :properties,           :jsonb,   null: false, default: "{}"

      timestamps()
    end

    create unique_index("calendar_events", [:identifier])

  end
end
