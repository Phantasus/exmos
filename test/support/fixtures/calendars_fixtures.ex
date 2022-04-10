defmodule Mos.CalendarsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mos.Calendars` context.
  """

  @doc """
  Generate a calendar_event.
  """
  def calendar_event_fixture(attrs \\ %{}) do
    {:ok, calendar_event} =
      attrs
      |> Enum.into(%{
        display_name: "some display_name",
        enddate: ~U[2022-04-09 16:49:00Z],
        enddate_utc_offset: 42,
        startdate: ~U[2022-04-09 16:49:00Z],
        startdate_utc_offset: 42,
        teaser: "some teaser"
      })
      |> Mos.Calendars.create_calendar_event()

    calendar_event
  end
end
