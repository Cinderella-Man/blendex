defmodule Blendex do
  @moduledoc """
  Documentation for `Blendex`.
  """

  alias Blendex.Converter

  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> Blendex.draw_shapes()
      :ok

  """

  def generate_commands(commands, file_path \\ "output.py") do

    data = commands
    |> Enum.map(&Converter.transpile_command/1)
    |> Enum.join("\n")

    Logger.debug("""
    ------------------OUTGOING--------------------
    Data to be saved to file:
    #{data}\n
    """)

    File.write(file_path, data)

    Logger.debug("Data saved")
  end
end
