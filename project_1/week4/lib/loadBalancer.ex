defmodule LoadBalancer do
  use GenServer

  def start_link(number) do
    IO.puts("LoadBalancer is starting")
    GenServer.start_link(__MODULE__, %{number: number, last_worker: 0}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  def handle_info({:number, new_number}, state) do
    {:noreply, %{state | number: new_number}}
  end

  @impl true
  def handle_info(message, state) do
    text = message["message"]["tweet"]["text"]
    worker_id = round_robin_worker(state)

    [
      "redactor",
      "sentiment_scorer",
      "engagement_rationer"
    ]
    |> Enum.each(fn id ->
      worker = :"#{id}#{worker_id}"
      if Process.whereis(worker) != nil do
        send(worker, {:msg, {create_msg_id(text), message}})
      end
    end)

    {:noreply, update_last_worker(state, worker_id)}
  end

  defp create_msg_id(text) do
    :crypto.hash(:sha256, text) |> Base.encode16 |> String.downcase
  end

  defp update_last_worker(state, worker_id) do
    last_worker = if worker_id == state[:number], do: 1, else: worker_id + 1
    %{state | last_worker: last_worker}
  end

  defp round_robin_worker(state) do
    if state[:last_worker] == state[:number] do
      1
    else
      state[:last_worker] + 1
    end
  end
end
