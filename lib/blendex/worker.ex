defmodule Blendex.Worker do
  use GenServer
 
  @blender_host Application.compile_env(:blendex, :blender_host)
  @blender_port Application.compile_env(:blendex, :blender_port)

  alias Blendex.Converter

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    {:ok, nil, {:continue, nil}}
  end

  def handle_continue(_args, _state) do
    {:ok, socket} = :gen_tcp.connect(@blender_host, @blender_port, [:binary, active: true])
    {:noreply, socket}
  end

  def handle_call({:draw_shapes, shapes}, _from, socket) do
    shapes
    |> Enum.map(&Converter.generate_command/1)
    |> Enum.map(fn command -> :gen_tcp.send(socket, command); :timer.sleep(200) end)

    {:reply, :ok, socket}
  end

  def handle_info({:tcp, _port, _command}, state) do
    {:noreply, state}
  end
end