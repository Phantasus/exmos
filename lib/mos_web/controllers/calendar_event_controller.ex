defmodule MosWeb.CalendarEventController do
  use MosWeb, :controller

  alias Mos.Calendars
  alias Mos.Calendars.CalendarEvent

  def index(conn, _params) do
    calendar_events = Calendars.list_calendar_events()
    render(conn, "index.html", calendar_events: calendar_events)
  end

  def new(conn, _params) do
    changeset = Calendars.change_calendar_event(%CalendarEvent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"calendar_event" => calendar_event_params}) do
    case Calendars.create_calendar_event(calendar_event_params) do
      {:ok, calendar_event} ->
        conn
        |> put_flash(:info, "Calendar event created successfully.")
        |> redirect(to: Routes.calendar_event_path(conn, :show, calendar_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    calendar_event = Calendars.get_calendar_event!(id)
    render(conn, "show.html", calendar_event: calendar_event)
  end

  def edit(conn, %{"id" => id}) do
    calendar_event = Calendars.get_calendar_event!(id)
    changeset = Calendars.change_calendar_event(calendar_event)
    render(conn, "edit.html", calendar_event: calendar_event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "calendar_event" => calendar_event_params}) do
    calendar_event = Calendars.get_calendar_event!(id)

    case Calendars.update_calendar_event(calendar_event, calendar_event_params) do
      {:ok, calendar_event} ->
        conn
        |> put_flash(:info, "Calendar event updated successfully.")
        |> redirect(to: Routes.calendar_event_path(conn, :show, calendar_event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", calendar_event: calendar_event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    calendar_event = Calendars.get_calendar_event!(id)
    {:ok, _calendar_event} = Calendars.delete_calendar_event(calendar_event)

    conn
    |> put_flash(:info, "Calendar event deleted successfully.")
    |> redirect(to: Routes.calendar_event_path(conn, :index))
  end
end
