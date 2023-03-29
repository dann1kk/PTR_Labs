defmodule Week3 do
# minimal

  def printMessage do
    receive do
      msg ->
        IO.puts(msg)
    end
    printMessage()
  end
  # pid = spawn(Week3, :printMessage, [])
  # send(pid, "Text")

  def modifier do
    receive do
      message when is_integer(message) ->
        msg = message + 1
        IO.puts("Received: " <> to_string(msg))
      message when is_bitstring(message) ->
        msg = String.downcase(message)
        IO.puts("Received: "  <> to_string(msg))
      message ->
        IO.puts("Received: I don't know how to HANDLE this!")
    end
    modifier()
  end
  # pid = spawn(Week3, :modifier, [])
  # send(pid, 10)
  # send(pid, "Hello")
  # send(pid, {10, "Hello"})

  def actor, do: exit(:bye)

  def actor_monitor(pid) do
    Process.monitor(pid)

    receive do
      {:DOWN, _ref, :process, ^pid, reason} ->
        IO.puts("Actor stopped!")
        IO.puts("Reason: "  <> to_string(reason))
    end
  end
  # pid = spawn(Week3, :actor, [])
  # Week3.actor_monitor(pid)

  def averager(sum, n) do
  receive do
    nr when is_number(nr) ->
      sum = sum + nr
      n = n + 1
      average = sum / n
      IO.puts("Current average is: " <> to_string(average))
      averager(sum, n)
    end
  end
  # pid = spawn(Week3, :averager, [0,0])
  # send(pid, 10)
  # send(pid, 10)

# main
  def new_queue do
    spawn(fn -> loop([]) end)
  end

  def push(pid, value) do
    send(pid, {:queue, value})
    :ok
  end

  def pop(pid) do
    ref = make_ref()
    send(pid, {:dequeue, self(), ref})
    receive do
      {:ok, ^ref, value} -> value
    end
  end

  defp loop(queue) do
    receive do
      {:queue, value} ->
        loop([value | queue])

      {:dequeue, sender, ref} ->
        if queue == [] do
          send(sender, {:error, ref, nil})
        else
          last = List.last(queue)
          send(sender, {:ok, ref, last})
          loop(List.delete_at(queue, -1))
        end
    end
  end
  # pid = Week3.new_queue()
  # Week3.push(pid, 1)
  # Week3.pop(pid)
end
