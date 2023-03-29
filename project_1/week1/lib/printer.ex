defmodule Printer do
  use GenServer

  def start_link(sleep_time) do
    GenServer.start_link(__MODULE__, {sleep_time}, name: __MODULE__)
  end

  def init({sleep_time}) do
    {:ok, {sleep_time}}
  end

  def handle_info(json, {sleep_time}) do
    Process.sleep(sleep_time)
    IO.puts("#{json["message"]["tweet"]["text"]}")
    {:noreply, {sleep_time}}
  end
end
