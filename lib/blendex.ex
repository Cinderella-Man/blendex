defmodule Blendex do
  @moduledoc """
  Documentation for `Blendex`.
  """

  @blender_host Application.compile_env(:blendex, :blender_host, "localhost")
  @blender_port Application.compile_env(:blendex, :blender_port, "8080")

  alias Blendex.Converter

  require Logger

  @doc """
  Hello world.

  :inets.start()
  :httpc.request(:get, {"http://localhost:8080/q/g/ew", []}, [], [])

  body = "My text"
  request = {"http://localhost:8080", [], 'text/plain', body}
  :httpc.request(:post, request, [], [])


  ## Examples

      iex> Blendex.draw_shapes()
      :ok

  """

  def send_commands(commands) do
    :inets.start()

    body = commands
    |> Enum.map(&Converter.transpile_command/1)
    |> Enum.join("\n")

    Logger.debug("""
    ------------------OUTGOING--------------------
    Request body to be send to the Blender server:
    #{body}\
    to the Blender server
    """)

    request = {"http://#{@blender_host}:#{@blender_port}", [], 'text/plain', body}
    {:ok, res} = :httpc.request(:post, request, [], [])

    Logger.debug("""
    -------------------INCOMING-------------------
    Response from the Blender server:\n #{elem(res, 2)}
    """)
  end
end
