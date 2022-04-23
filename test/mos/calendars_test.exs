defmodule Mos.CalendarsTest do
  use Mos.DataCase

  alias Mos.Calendars

  describe "calendars" do
    alias Mos.Calendars.Calendar

    import Mos.CalendarsFixtures

    test "creating a calendar" do
      valid_attrs = %{
        display_name: "My Calendar"
      }
      {:ok, new_calendar} = Calendars.create_calendar(valid_attrs)

      assert new_calendar.display_name == "My Calendar"
      assert is_struct(new_calendar, Calendar)
      assert String.length(new_calendar.identifier) == 50
      assert String.match?(new_calendar.identifier, ~r/[a-z]{50}/i)

      assert new_calendar.id > 0
    end
  end

  describe "calendar_events" do
    alias Mos.Calendars.CalendarEvent

    import Mos.CalendarsFixtures

    @invalid_attrs %{
      display_name: nil, enddate: nil,
      enddate_utc_offset: nil, startdate: nil,
      startdate_utc_offset: nil, teaser: nil
    }

    test "list_calendar_events/0 returns all calendar_events" do
      calendar_event = calendar_event_fixture()
      assert Calendars.list_calendar_events() == [calendar_event]
    end

    test "get_calendar_event!/1 returns the calendar_event with given id" do
      calendar_event = calendar_event_fixture()
      assert Calendars.get_calendar_event!(calendar_event.id) == calendar_event
    end

    test "create_calendar_event/1 with valid data creates a calendar_event" do
      valid_attrs = %{
        display_name: "some display_name",
        enddate: ~U[2022-04-09 16:49:00Z],
        enddate_utc_offset: 42,
        startdate: ~U[2022-04-09 16:49:00Z],
        startdate_utc_offset: 42,
        teaser: "some teaser"
      }

      assert {:ok, %CalendarEvent{} = calendar_event} = Calendars.create_calendar_event(valid_attrs)
      assert calendar_event.display_name == "some display_name"
      assert calendar_event.enddate == ~U[2022-04-09 16:49:00Z]
      assert calendar_event.enddate_utc_offset == 42
      assert calendar_event.startdate == ~U[2022-04-09 16:49:00Z]
      assert calendar_event.startdate_utc_offset == 42
      assert calendar_event.teaser == "some teaser"
      assert calendar_event.calendar_id > 0
    end

    test "create_calendar_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendars.create_calendar_event(@invalid_attrs)
    end

    test "update_calendar_event/2 with valid data updates the calendar_event" do
      calendar_event = calendar_event_fixture()
      update_attrs = %{
        display_name: "some updated display_name",
        enddate: ~U[2022-04-10 16:49:00Z],
        enddate_utc_offset: 43,
        startdate: ~U[2022-04-10 16:49:00Z],
        startdate_utc_offset: 43,
        teaser: "some updated teaser"
      }

      assert {:ok, %CalendarEvent{} = calendar_event} = Calendars.update_calendar_event(calendar_event, update_attrs)
      assert calendar_event.display_name == "some updated display_name"
      assert calendar_event.enddate == ~U[2022-04-10 16:49:00Z]
      assert calendar_event.enddate_utc_offset == 43
      assert calendar_event.startdate == ~U[2022-04-10 16:49:00Z]
      assert calendar_event.startdate_utc_offset == 43
      assert calendar_event.teaser == "some updated teaser"
    end

    test "update_calendar_event/2 with invalid data returns error changeset" do
      calendar_event = calendar_event_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendars.update_calendar_event(calendar_event, @invalid_attrs)
      assert calendar_event == Calendars.get_calendar_event!(calendar_event.id)
    end

    test "delete_calendar_event/1 deletes the calendar_event" do
      calendar_event = calendar_event_fixture()
      assert {:ok, %CalendarEvent{}} = Calendars.delete_calendar_event(calendar_event)
      assert_raise Ecto.NoResultsError, fn -> Calendars.get_calendar_event!(calendar_event.id) end
    end

    test "change_calendar_event/1 returns a calendar_event changeset" do
      calendar_event = calendar_event_fixture()
      assert %Ecto.Changeset{} = Calendars.change_calendar_event(calendar_event)
    end
  end
end
