defmodule MosWeb.AdminShellLive do
  use MosWeb, :live_view

  @impl true 
  def handle_event("eval", %{"command" => %{"line" => command}}, socket) do
    history = socket.assigns.history

    {new_history, socket} = case  eval_command(command, socket) do
                              {result, socket} ->
                                {inspect(result), socket}
                              {:error, error, stacktrace, socket} ->
                                {format_error(error, stacktrace), socket}
                            end

    line_number = socket.assigns.line_number
    command_id = "command#{line_number}"

    new_items = [
      %{id: command_id, value: new_prompt(command, socket)},
      %{id: "result#{line_number}", value: new_history}
    ]
    
    changes =  [
      history: history ++ new_items
    ]
    
    {:noreply, push_event(assign(socket, changes), "goto", %{id: command_id})}
  end

  def format_error(error, stacktrace) do
    error_string = Exception.format(:error, error, stacktrace)

    "<pre style=\"color: red\">#{error_string}</pre>"
  end
  
  @impl true
  def mount(params, session, socket) do
    {:ok, assign(socket, history: [], binding: [], line_number: 0)}
  end

  def new_prompt(command, socket) do
    line_nr = socket.assigns.line_number

    "iex(#{line_nr})> #{command}"
  end

  def eval_command(command, socket) do
    line_nr = socket.assigns.line_number + 1
    binding = socket.assigns.binding

    try do
      {result, new_binding} = Code.eval_string(command, binding, line: line_nr)
      
      socket = assign(socket, line_number: line_nr, binding: new_binding)

      {result, socket}
    rescue
      e -> {:error, e, __STACKTRACE__, assign(socket, line_number: line_nr)}
    end
  end
end
