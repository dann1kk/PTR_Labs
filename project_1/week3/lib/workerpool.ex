defmodule WorkerPool do
  use Supervisor

  def start_link(init_arg \\ :ok) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      %{id: :printer1,start: {Printer, :start_link, [:printer1, 50]}},
      %{id: :printer2,start: {Printer, :start_link, [:printer2, 50]}},
      %{id: :printer3,start: {Printer, :start_link, [:printer3, 50]}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
