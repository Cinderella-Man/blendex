defmodule Blendex do
  @moduledoc """
  Documentation for `Blendex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Blendex.draw_shapes()
      :ok

  """
  def draw_graphic() do

    shapes = [
      %{type: :cube, size: 2, location: {0, 0, 0}, scale: {1, 1, 1}}
    ]

    draw_shapes(shapes)
  end


  def draw_shapes(shapes) do
    GenServer.call(Blendex.Worker, {:draw_shapes, shapes})
  end
end
