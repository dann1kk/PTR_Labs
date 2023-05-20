defmodule Aggregator do
  use GenServer

  def start_link(state) do
    IO.puts("Aggregator starting")
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_info({:set, {id, key, value}}, state) do
    current_map =
      case Map.get(state, id) do
        nil ->
          %{}

        map ->
          map
      end

    merged_map =
      current_map
      |> Map.merge(%{key => value})

    state =
      case map_size(merged_map) == 3 do
        true ->
          send(Batcher, {:send, merged_map})

          Map.delete(state, id)

        false ->
          Map.put(state, id, merged_map)
      end

    {:noreply, state}
  end
end
