defmodule Mos.Calendars.CalendarEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calendar_events" do
    field :identifier,           :string
    field :display_name,         :string
    field :enddate,              :utc_datetime
    field :enddate_utc_offset,   :integer
    field :startdate,            :utc_datetime
    field :startdate_utc_offset, :integer
    field :teaser,               :string

    timestamps()
  end

  @doc false
  def changeset(calendar_event, attrs) do
    calendar_event
    |> cast(attrs, [:display_name, :teaser, :startdate, :startdate_utc_offset, :enddate, :enddate_utc_offset])
    |> validate_required([:display_name, :teaser, :startdate, :startdate_utc_offset, :enddate, :enddate_utc_offset])
  end
end
