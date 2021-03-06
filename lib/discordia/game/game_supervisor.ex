defmodule Discordia.GameSupervisor do
  @moduledoc """
  Supervisor for all games. It supervises a RoomSupervisor, which in turn
  supervises a GameServer worker and several Player workers.
  """

  use Supervisor

  def start_link() do
    {:ok, _} = Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      supervisor(Discordia.RoomSupervisor, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
