defmodule Week4.WorkersPool do
  def start_group() do
    w_list = [Worker1, Worker2, Worker3, Worker4, Worker5]

    children = for w_name <- w_list do
      %{id: w_name, start: {Week4.WorkersPool.WorkerNode, :start_link, [w_name]}}
    end

    {:ok, supervisor_pid} = Supervisor.start_link(children, strategy: :one_for_one)
    worker_pids = Supervisor.which_children(supervisor_pid) |> Enum.map(&elem(&1, 1))
    {supervisor_pid, worker_pids}
  end
end

defmodule Week4.WorkersPool.WorkerNode do
  def start_link(w_name) do
    pid = spawn_link(fn -> loop(w_name) end)
    {:ok, pid}
  end

  def loop(w_name) do
    receive do
      {:kill} ->
        Process.flag(:trap_exit, true)
        exit(:stop)

      {:message, message} ->
        message |> IO.puts()
        loop(w_name)
    end
  end

  def kill(pid) do
    send(pid, {:kill})
  end

  def message(pid, message) do
    send(pid, {:message, message})
  end
end

## {supervisor_pid, pids} = Week4.WorkersPool.start_group()
## Week4.WorkersPool.WorkerNode.message(Enum.at(pids, 0), "Hello")
## Week4.WorkersPool.WorkerNode.kill(Enum.at(pids, 2))
## workers = Supervisor.which_children(supervisor_pid)
