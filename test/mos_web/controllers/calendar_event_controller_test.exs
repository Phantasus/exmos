defmodule MosWeb.CalendarEventControllerTest do
  use MosWeb.ConnCase

  import Mos.CalendarsFixtures

  @create_attrs %{display_name: "some display_name", enddate: ~U[2022-04-09 16:49:00Z], enddate_utc_offset: 42, startdate: ~U[2022-04-09 16:49:00Z], startdate_utc_offset: 42, teaser: "some teaser"}
  @update_attrs %{display_name: "some updated display_name", enddate: ~U[2022-04-10 16:49:00Z], enddate_utc_offset: 43, startdate: ~U[2022-04-10 16:49:00Z], startdate_utc_offset: 43, teaser: "some updated teaser"}
  @invalid_attrs %{display_name: nil, enddate: nil, enddate_utc_offset: nil, startdate: nil, startdate_utc_offset: nil, teaser: nil}

  describe "index" do
    test "lists all calendar_events", %{conn: conn} do
      conn = get(conn, Routes.calendar_event_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Calendar events"
    end
  end

  describe "new calendar_event" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.calendar_event_path(conn, :new))
      assert html_response(conn, 200) =~ "New Calendar event"
    end
  end

  describe "create calendar_event" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.calendar_event_path(conn, :create), calendar_event: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.calendar_event_path(conn, :show, id)

      conn = get(conn, Routes.calendar_event_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Calendar event"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.calendar_event_path(conn, :create), calendar_event: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Calendar event"
    end
  end

  describe "edit calendar_event" do
    setup [:create_calendar_event]

    test "renders form for editing chosen calendar_event", %{conn: conn, calendar_event: calendar_event} do
      conn = get(conn, Routes.calendar_event_path(conn, :edit, calendar_event))
      assert html_response(conn, 200) =~ "Edit Calendar event"
    end
  end

  describe "update calendar_event" do
    setup [:create_calendar_event]

    test "redirects when data is valid", %{conn: conn, calendar_event: calendar_event} do
      conn = put(conn, Routes.calendar_event_path(conn, :update, calendar_event), calendar_event: @update_attrs)
      assert redirected_to(conn) == Routes.calendar_event_path(conn, :show, calendar_event)

      conn = get(conn, Routes.calendar_event_path(conn, :show, calendar_event))
      assert html_response(conn, 200) =~ "some updated display_name"
    end

    test "renders errors when data is invalid", %{conn: conn, calendar_event: calendar_event} do
      conn = put(conn, Routes.calendar_event_path(conn, :update, calendar_event), calendar_event: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Calendar event"
    end
  end

  describe "delete calendar_event" do
    setup [:create_calendar_event]

    test "deletes chosen calendar_event", %{conn: conn, calendar_event: calendar_event} do
      conn = delete(conn, Routes.calendar_event_path(conn, :delete, calendar_event))
      assert redirected_to(conn) == Routes.calendar_event_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.calendar_event_path(conn, :show, calendar_event))
      end
    end
  end

  defp create_calendar_event(_) do
    calendar_event = calendar_event_fixture()
    %{calendar_event: calendar_event}
  end
end
