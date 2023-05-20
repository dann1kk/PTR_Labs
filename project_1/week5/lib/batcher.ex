defmodule Batcher do
  use GenServer

  def start_link([state, buffer_size, max_time]) do
    IO.puts("Batcher starting")
    GenServer.start_link(__MODULE__, {state, buffer_size, max_time}, name: __MODULE__)
  end

  def init({state, buffer_size, max_time}) do
    pid = spawn_link(fn -> loopBufferTimeout(max_time) end)
    Process.register(pid, :batcher_checker)
    {:ok, {state, buffer_size}}
  end

  def loopBufferTimeout(max_time) do
    receive do
      {:bufferfull, state} ->
        print_state(state)
        loopBufferTimeout(max_time)
    after
      max_time ->
        state = GenServer.call(Batcher, :get_state)
        send(Batcher, :set_state)
        print_state(state)
        loopBufferTimeout(max_time)
    end
  end

  def print_state(state) do
    state
    |> Enum.each(fn merged_map ->
      IO.puts(
            "#{merged_map[:redactor]} \n
            Emotional Score: #{merged_map[:sentiment_score]} \n
            Engagement Ratio: #{merged_map[:eng_ratio]} \n"
          )
    end)
  end

  def handle_call(:get_state, _, {state, buffer_size}) do
    {:reply, state, {state, buffer_size}}
  end

  def handle_info(:set_state, {_state, buffer_size}) do
    {:noreply, {[], buffer_size}}
  end

  def handle_info({:send, map}, {state, buffer_size}) do
    state = state ++ [map]

    state =
      case length(state) == buffer_size do
        true ->
          send(:batcher_checker, {:bufferfull, state})
          []

        false ->
          state
      end

    {:noreply, {state, buffer_size}}
  end
end
