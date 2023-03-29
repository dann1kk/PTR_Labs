defmodule Printer do
  use GenServer

  def start_link(id, sleep_time) do
    GenServer.start_link(__MODULE__, {id, sleep_time}, name: id)
  end

  def init({id, sleep_time}) do
    {:ok, {id, sleep_time}}
  end

  def handle_info(json, {id, sleep_time}) do
    Process.sleep(sleep_time)
    IO.puts("#{id}: #{json["message"]["tweet"]["text"]}")
    {:noreply, {id, sleep_time}}
  end
end
