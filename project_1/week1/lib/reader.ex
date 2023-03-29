defmodule Reader do
  use GenServer

  def start_link(name, url) do
    GenServer.start_link(__MODULE__, url, name: name)
  end

  def init(url) do
    HTTPoison.get!(url, [], recv_timeout: :infinity, stream_to: self())
    {:ok, url}
  end

  def handle_info(%HTTPoison.AsyncChunk{chunk: ""}, url) do
    HTTPoison.get!(url, [], recv_timeout: :infinity, stream_to: self())
    {:noreply, url}
  end

  def handle_info(
        %HTTPoison.AsyncChunk{chunk: "event: \"message\"\n\ndata: {\"message\": panic}\n\n"},
        url
      ) do
    {:noreply, url}
  end

  def handle_info(%HTTPoison.AsyncChunk{chunk: data}, url) do
    [_, json] = Regex.run(~r/data: ({.+})\n\n$/, data)
    {:ok, result} = json |> Poison.decode()
    send(Printer, result)
    {:noreply, url}
  end

  def handle_info(_, url) do
    {:noreply, url}
  end
end
